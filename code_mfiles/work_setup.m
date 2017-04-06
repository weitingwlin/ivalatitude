%% Set up working folder and utility path

clear;clc
%% Get current machine name
[stt, strout] =system('hostname');

%%%% set working directory and path
if strncmp(strout, 'weitingdeAir',12)||strncmp(strout, 'weitingdeMacBook-Air',5)
    cd '/Users/weitinglin/Dropbox/PhD_projects/iva_latitude/code_mfiles'
    addpath '/Users/weitinglin/Dropbox/DataCoding/utility_wtl/mfiles'
    addpath '/Users/weitinglin/Dropbox/DataCoding/utility_wtl_ecology/mfiles'
    addpath '/Users/weitinglin/Dropbox/DataCoding/MATLAB/FTM/Fathom';

end
% PC; now it is in the lab
if strncmp(strout, 'wlin_pc',5)
        cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\iva_latitude\code_mfiles'
        addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\utility_wtl\mfiles'
       addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\MATLAB\FTM\Fathom';
       rdatapath = 'C:\Users\Wei-Ting\Dropbox\PhD_projects\iva_latitude\code_rfiles\Rdata';
end
%
clear stt strout
pwd