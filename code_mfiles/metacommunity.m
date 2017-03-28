% Metacommunity maker
% group communities (rows) into metacommunity by information provided in infoin
% 
% SYNTAX
%              [matout, infoout] = metacommunity(matin, infoin)
% 
% each row in matin and matout is one community or metacommunity,
% where each column is a taxa
% 

function [matout, infoout] = metacommunity(matin, infoin, mode)
if nargin <3
    mode = 'sum';
end
infoout = unique(infoin,'rows'); % information of the output matacommunities
nM = length(infoout(:,1)); % number of metacommunities
nT = length(matin(1,:)); % number of taxa

if strcmp(mode,'count')
matout = zeros(nM, 1);
else
 matout = zeros(nM, nT);   
end
for i = 1 : nM
        ind = ismember(infoin, infoout(i,:),'rows'); % row index for communities to be grouped
        if strcmp(mode,'mean')
            matout(i,:) = nanmean( matin(ind,:) ); 
        elseif strcmp(mode,'count')
             matout(i) = sum(~isnan(sum(matin(ind,:), 2)));
        else
            matout(i,:) = sum( matin(ind,:) ); 
        end
end
