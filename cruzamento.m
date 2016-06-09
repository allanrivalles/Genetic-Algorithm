function [img_0,n_ind_selec_cruz] = cruzamento(ind_selec,n_ind_selec,img,n_elem,n_elem_cruz)

% % % function [img_0,n_ind_selec_cruz,rank_ind_cruz] = cruzamento(ind_selec,n_ind_selec,img,n_elem,n_elem_cruz,n_ind,cod_img,n_eletr,pot_borda_obj_estudo)

% function img_0 = cruzamento(n_ind_selec,img_00,n_elem,n_elem_cruz)

%    img_0 = cruzamento(rank_ind_selec,n_ind_selec,ind_selec,img,n_elem,n_elem_cruz)                   
%                                                                      
% MUTACAO - Acrescenta um ru�do de aleat�rio a condutividade de elementos aleat�rios dos indiv�duos selecionados  
% img_0 => vetor que cont�m todas as imagens de condutividade dos indiv�duos cruzados
% rank_ind_selec => vetor contendo os erros relativos dos indiv�duos
% n_ind_selec => n�mero de indiv�duos selecionados
% ind_selec => vetor formado pelas posi��es dos individuos selecionados em rela��o a todos os indiv�duos criados
% img => vetor de indiv�duos com distribui��o interna de condutividade el�trica aleat�rio 
% n_elem => n� total de elementos do objeto de estudo discretizado
% n_elem_cruz => n� de elementos selecionados para serem cruzados
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 28/05/13                                             
% Data de atualiza��o: 13/06/13    

u = 0;
for p = 1:n_ind_selec
    for i = u*1+1:p*n_ind_selec
        img_0(i).elem_data = img(ind_selec(p)).elem_data;
    end
    u = p*n_ind_selec;
end

n_elem_img = n_elem;
for j = 1:n_elem_cruz
    pos(j) = 0;
    while pos(j) <= 0
        pos(j) = round(n_elem_img*rand(1));
        for k = 1:j-1
            if (pos(j) == pos(k)) && j~=1
                pos(j) = pos(j)-1;
            end
        end
    end

    m = 0;
    for z = 1:n_ind_selec
        for k = m*1+1:z*n_ind_selec
            img_0(k).elem_data(pos(j)) = img(ind_selec(z)).elem_data(pos(j));
        end
        m = z*n_ind_selec;
    end
end

n_ind_selec_cruz = n_ind_selec*n_ind_selec;


end








