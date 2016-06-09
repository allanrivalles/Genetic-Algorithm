function [img,n_elem] = populacao_inicial (n_ind,cod_img,n_eletr)

%     [img,n_elem] = populacao_inicial (n_ind,cod_img,n_eletr)                     
%                                                                      
% POPULA��O INICIAL - Calcula os indiv�duos (poss�veis solu��es)                         
% img => os indiv�duos com distribui��o interna                  
%            de condutividade el�trica aleat�rio 
% n_elem => n� total de elementos da imagem do objeto de estudo discretizada
% n_ind => n�mero de indiv�duos
% cod_img => c�digo da imagem pelo EIDORS
% n_eletr => n� de eletrodos de borda
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 28/05/13                                             
% Data de atualiza��o: 13/06/13           

imdl_1d = mk_common_model(cod_img, n_eletr);  
img1 = mk_image(imdl_1d.fwd_model,1);
n_elem = length(img1.elem_data)
% % % val_cor = 0.1;
% fixando a distribui��o de condutividade el�trica nos indiv�duos
% % % imgr = img_reconst_cond(cod_img,n_eletr,pot_borda_obj_estudo,val_cor);
for j = 1:n_elem
    img1.elem_data(j) = (1/5)*rand(1);
end
img(1).elem_data = img1.elem_data;
% % %     imdl_1d = mk_common_model(cod_img, n_eletr);  
% % %     imgr = mk_image(imdl_1d.fwd_model,1);
% % %     imgr.elem_data = img(i).elem_data;
% % % figure; show_fem(imgr,[1,1]); axis off
% % %     title(strcat('Indiv�duo',num2str(i),'da popula��o'));
% % %     saveas(gcf,strcat('imagem_indiv�duo_',num2str(i),'.jpg'));


for i = 2:n_ind
    for j = 1:n_elem
    img1.elem_data(j) = (0.1*(2*rand(1) - 1))*img(1).elem_data(j);
    end
    img(i).elem_data = img1.elem_data;
% % %     figure; show_fem(img1,[1,1]); axis off
end

end
