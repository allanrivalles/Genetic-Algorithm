function ind_selec = selecao_ind(rank_ind,n_ind_selec)

%       [rank_ind_selec,ind_selec] = selecao_ind(rank_ind,n_ind_selec)
%                                                                      
% SELECAO_IND - Seleciona os indivíduos a partir da teoria da seleção por roleta   
% rank_ind_selec => vetor formado pelos erros relativos dos indivíduos selecionados
% ind_selec => vetor formado pelas posições dos individuos selecionados em relação a todos os indivíduos criados
% rank_ind => vetor formado pelos erros relativos de todos os indivíduos  
% n_ind_selec => nº de indivíduos a serem selecionados
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Graduação em Eng. Biomédica - CTG / UFPE                     
% Data de criação: 28/05/13                                             
% Data de atualização: 13/06/13      

T = 0;
n_ind = length(rank_ind);
for i = 1:n_ind
    T = T + rank_ind(i);
end
 
% Selecionado aleatoriamente o erro dos indivíduos mais aptos a solucionar o problema
min_rank = min(rank_ind);
ind_selec(1) = 0; 
for j = 1:n_ind
    if (rank_ind(j) == min_rank) && (ind_selec(1) == 0)
        ind_selec(1) = j;
        rank_ind_selec(1) = min_rank;
    end
end

% % % k = 2;
% % % while k <= n_ind_selec-1
% % %     r = T*rand(1);
% % %     for z = 1:n_ind
% % %         S = rank_ind(z);
% % %         if (S <= r) && (k <= n_ind_selec) && (z ~= ind_selec(1)) 
% % %             ind_selec(k) = z;
% % %             rank_ind_selec(k) = S;
% % %             k = k+1;            
% % %         end       
% % %     end
% % % end

S = 0;
k = 2;
while k <= n_ind_selec
    for z = 1:n_ind
        r = T*rand(1);
        S = S+rank_ind(z);
        if (S <= r) && (k <= n_ind_selec) && (z ~= ind_selec(1)) 
            ind_selec(k) = z;
            rank_ind_selec(k) = S;
            k = k+1;            
        end       
    end
end

end


        
    
