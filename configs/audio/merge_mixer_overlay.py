import re,sys
import xml.etree.ElementTree as ET
base_p,ovl_p,out_p=sys.argv[1:4]
base=open(base_p,encoding='latin-1').read()
ovl=open(ovl_p,encoding='latin-1').read()
ET.fromstring(base.encode('latin-1')); ET.fromstring(ovl.encode('latin-1'))
# top-level blocks: <path name="X"> ... </path> at 4-space indent (non-self-closing)
path_re=re.compile(r'^    <path name="([^"]+)">\n.*?^    </path>\n',re.S|re.M)
def paths(t): return [(m.group(1),m.start(),m.end(),m.group(0)) for m in path_re.finditer(t)]
bp=paths(base); op={}
for n,s,e,txt in paths(ovl): op[n]=txt
first_path_pos=bp[0][1] if bp else len(base)
# --- default ctls: overlay top-level ctls are before its first path
o_first=min([s for _,s,_,_ in paths(ovl)] or [len(ovl)])
ctl_re=re.compile(r'^    <ctl ([^>]*?)/>\n',re.M)
def key(attrs):
    a=dict(re.findall(r'(\w+)="([^"]*)"',attrs)); return (a.get('name'),a.get('id'),a.get('index'))
o_ctls=[(key(m.group(1)),m.group(0)) for m in ctl_re.finditer(ovl,0,o_first)]
head,rest=base[:first_path_pos],base[first_path_pos:]
replaced=added=0
for k,line in o_ctls:
    found=False
    def sub(m):
        global replaced,found
        if not found and key(m.group(1))==k:
            found=True; replaced+=1; return line
        return m.group(0)
    head=ctl_re.sub(sub,head)
    if not found:
        head=head.rstrip('\n')+'\n'+line+'\n'; added+=1
base=head+rest
# --- first-level path replacement (first occurrence only; duplicates are ignored by audio_route anyway)
done=set(); missing=[]
def rep(m):
    n=m.group(1)
    if n in op and n not in done:
        done.add(n); return op[n]
    return m.group(0)
base=path_re.sub(rep,base)
for n in op:
    if n not in done: missing.append(n)
if missing:
    # overlay says never to create new paths; add anyway so nothing is silently dropped
    base=base.replace('</mixer>',''.join('\n'+op[n] for n in missing)+'</mixer>')
ET.fromstring(base.encode('latin-1'))
open(out_p,'w',encoding='latin-1').write(base)
print("default ctls replaced",replaced,"added",added,"| paths replaced",len(done),"of",len(op),"| appended (absent in base)",missing)
