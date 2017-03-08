    clear;clc
    work_compile3
    
%% kind
kindid =Tguildtaxon.kind_ID;

kindabu = sum(wbugdata);
% save('kindabu.txt','kindabu','-ascii')
cuta = quantile(kindabu, [0.8])
%lista = kindid(kindabu > cuta)
kindocc = sum(wbugdata > 0);
cuto = quantile(kindocc, [0.8])
%listo = kindid(kindocc > cuto)
list3 = any([kindabu > cuta ; kindocc > cuto]);
list4 =all( [list3 ; Tguildtaxon.taxon2'==0])
kindid(list4)'
%%
