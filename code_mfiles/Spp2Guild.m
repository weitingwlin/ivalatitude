% a function to translate species matrix to guild matrix
%  
% SYNTAX  [matout, guildout] = Spp2Guild(matin, Guild)
%          matin : n x p matrix, n is number of sample, p is original kinds
%          Guild : vector (length = p), guild of each kind
%
%          matout : functional diversity matrix n x q, q is number of guilds
%          guildout: list of guild, column names of matout
%
%  Wei-Ting Lin 2016/07/28
function [matout, guildout] = Spp2Guild(matin, Guild, removelist)

    guildlist = unique(Guild);
    B = matin;
    matout = zeros(length(matin(:,1)), length(guildlist));
    for i = 1: length(Guild) % for each original kinds
           ind = find(guildlist == Guild(i)); % which guild in guildlist is the original kind
           matout(:, ind) = matout(:, ind) + B(:,i) ;
    end
    
    guildout = guildlist;
    
    %%% remove
    if nargin ==3
        for i = 1: length(removelist)
           idin = guildout ~= removelist(i);
                guildout = guildout(idin);    
                matout = matout(:, idin);
        end
    end  