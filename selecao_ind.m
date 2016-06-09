function ind_selec = selecao_ind(rank_ind,n_ind_selec)

%       [rank_ind_selec,ind_selec] = selecao_ind(rank_ind,n_ind_selec)
%                                                                      
% SELECAO_IND - Seleciona os indiv�duos a partir da teoria da sele��o por roleta   
% rank_ind_selec => vetor formado pelos erros relativos dos indiv�duos selecionados
% ind_selec => vetor formado pelas posi��es dos individuos selecionados em rela��o a todos os indiv�duos criados
% rank_ind => vetor formado pelos erros relativos de todos os indiv�duos  
% n_ind_selec => n� de indiv�duos a serem selecionados
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 28/05/13                                             
% Data de atualiza��o: 13/06/13      

T = 0;
n_ind = length(rank_ind);
for i = 1:n_ind
    T = T + rank_ind(i);
end
 
% Selecionado aleatoriamente o erro dos indiv�duos mais aptos a solucionar o problema
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


        
    
