function [img_1,rank_ind_mutado,n_calc_erro] = mutacao(img_0,n_ind_selec_cruz,n_elem_selec,cod_img,n_eletr,pot_borda_obj_estudo,n_elem,perc_ruido,n_calc_erro)

% % % function [img_1,rank_ind_mutado] = mutacao(img_0,n_ind_selec_cruz,n_elem_selec,cod_img,n_eletr,pot_borda_obj_estudo,n_elem,perc_ruido,rank_ind_cruz)

%    [img_1,rank_ind_mutado] = mutacao(img_0,n_ind_selec,n_elem_selec,cod_img,n_eletr,pot_borda_obj_estudo,n_elem)                   
%                                                                      
% MUTACAO - Acrescenta um ru�do aleat�rio a condutividade de elementos aleat�rios dos indiv�duos selecionados  
% img_1 => vetor que contem todas as imagens de condutividade do indiv�duos mutados
% rank_ind_mutado => vetor de erro relativos dos indiv�duos mutados
% img_0 => vetor que contem todas as imagens de condutividade do indiv�duos cruzados
% ind_selec => vetor formado pelas posi��es dos individuos selecionados em rela��o a todos os indiv�duos criados
% n_elem_selec => n� de elementos selecionados para serem mutados
% cod_img => c�digo da imagem pelo EIDORS
% n_eletr => n� de eletrodos de borda
% pot_borda_obj_estudo => Distribui��o de potencial de borda do objeto de estudo 
% n_elem => n� total de elementos da imagem do objeto de estudo discretizada
% perc_ruido => percentual de ruido (valor entre 0 e 1)
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 28/05/13                                             
% Data de atualiza��o: 13/06/13    

% acrescentando um ru�do de aleat�rio na condutividade de posi��es aleat�rias(pos) (elementos dos indiv�duos selecionados)
img_1(1).elem_data = img_0(1).elem_data; 
for i = 2:n_ind_selec_cruz
    n_elem_img = n_elem;
    img_1(i).elem_data = img_0(i).elem_data; 
    for j = 1:n_elem_selec
        pos(j) = 0;
        while pos(j) <= 0
            pos(j) = round(n_elem_img*rand(1));
            for k = 1:j-1
                if (pos(j) == pos(k)) && j~=1
                    pos(j) = pos(j)-1;
                end
            end 
        end
        % Ru�do aleat�rio de +/- 5% da condutividade el�trica no elemento
        img_1(i).elem_data(pos(j)) = (1 + perc_ruido*(2*rand(1) - 1))*img_0(i).elem_data(pos(j));
    end
end

% % % t = 1;
% % % rank = rank_ind_cruz;
% % % while t <= length(rank_ind_cruz)
% % %     for i = 1:length(rank_ind_cruz)
% % %         RANKmax = max(rank);
% % %         if rank(i) == RANKmax
% % %             pos_img(t) = i;
% % %             rank(i) = 0;
% % %             t = t+1;
% % %         end
% % %     end
% % % end
% % %         
% % % for k =(0.99*n_ind_selec_cruz+1):n_ind_selec_cruz
% % %     img_1(k).elem_data = img_0(pos_img(k)).elem_data;
% % % end
% % % 
% % % for i = 1:0.99*n_ind_selec_cruz
% % %     n_elem_img = n_elem;
% % %     img_1(i).elem_data = img_0(pos_img(i)).elem_data; 
% % %     for j = 1:n_elem_selec
% % %         pos(j) = 0;
% % %         while pos(j) <= 0
% % %             pos(j) = round(n_elem_img*rand(1));
% % %             for k = 1:j-1
% % %                 if (pos(j) == pos(k)) && j~=1
% % %                     pos(j) = pos(j)-1;
% % %                 end
% % %             end 
% % %         end
% % %         % Ru�do aleat�rio de +/- 5% da condutividade el�trica no elemento
% % %         img_1(i).elem_data(pos(j)) = (1 + perc_ruido*(2*rand(1) - 1))*img_0(pos_img(i)).elem_data(pos(j));
% % %     end
% % % end

% Calculando um vetor de erro relativo para os indiv�duos mutados
n_ind = n_ind_selec_cruz;
[rank_ind_mutado,n_calc_erro] = avaliacao_aptidao(img_1,n_ind,cod_img,n_eletr,pot_borda_obj_estudo,n_calc_erro);

end
