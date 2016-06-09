function [rank_ind_selec_mutado,img_selec_mutada,sol_encontrada,iter_max1] = criterio_parada(rank_ind_mutado,img_1,cod_img,n_eletr,iter,iter_max)
%  [rank_ind_selec_mutado,img_selec_mutada,sol_encontrada] = criterio_parada(pot_borda_obj_estudo,rank_ind_selec,rank_ind_mutado,n_ind_selec,img,img_1,erro_max,ind_selec,cod_img,n_eletr)                  
%                                                                      
% CRITERIO_PARADA - Procura o indiv�duo que tenho erro relativo menor que o erro m�ximo    
% rank_ind_selec_mutado => vetor contendo os erros de todos indiv�duos selecionados e mutados 
% img_selec_mutada => vetor de imagens contendo as condutividades de todos indiv�duos selecionados, cruzados e mutados  
% sol_encontrada => uma v�riavel usada para indicar se houve ou n�o a converg�ncia
% pot_borda_obj_estudo => Distribui��o de potenciais el�tricos na borda do objeto de estudo (procurado)
% rank_ind_selec => vetor contendo os erros de todos indiv�duos selecionados
% rank_ind_mutado => vetor contendo os erros de todos indiv�duos mutados
% n_ind_selec => n� de indiv�duos selecionados
% img => vetor contendos indiv�duos com distribui��o interna de condutividade el�trica aleat�rio
% img_1 => vetor que contem todas as imagens de condutividade do indiv�duos mutados
% erro_max => erro m�ximo para converg�ncia
% ind_selec => vetor formado pelas posi��es dos individuos selecionados em rela��o a todos os indiv�duos criados
% cod_img => c�digo da imagem pelo EIDORS
% n_eletr => n� de eletrodos de borda
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 28/05/13                                             
% Data de atualiza��o: 13/06/13    

% Criando um vetor com os erros (EQM) dos indiv�duos selecionados (pais) e mutados (filhos)
rank_ind_selec_mutado = [rank_ind_mutado];
n_ind_selec_mutado = length(rank_ind_mutado);

% Criando um vetor de imagens dos indiv�duos selecionados (pais) e mutados (filhos)
imax = n_ind_selec_mutado;
for j = 1:imax
    img_selec_mutada(j).elem_data = img_1(j).elem_data;
end

% Ordenando de forma crescente o vetor de erro (EQM) dos indiv�duos selecionados (pais) e mutados (filhos)
rank_ind_selec_mut_ordenado = sort(rank_ind_selec_mutado,'ascend');
erro_min_now = rank_ind_selec_mut_ordenado(1);

% Fazendo a converg�ncia, convergindo quando sol_encontrada = 1
iter_max1 = iter_max;
sol_encontrada = 0;
i = 1;
while (sol_encontrada ~= 1) && (i <= imax)
    if (rank_ind_selec_mutado(i) == rank_ind_selec_mut_ordenado(1))
        erro_procurado = rank_ind_selec_mut_ordenado(1);
        rank_ind_mel = rank_ind_selec_mutado(i);

        % Imagem de distribui��o de condutividade el�trica procurada
        imdl_2d = mk_common_model(cod_img, n_eletr);  
        img_procurada = mk_image(imdl_2d.fwd_model,1);
        img_procurada.elem_data = img_selec_mutada(i).elem_data;
        
        if (iter == 50)||(iter == 100)||(iter == 150)||(iter == 200)||(iter == 250)||(iter == 300)||(iter == 350)||(iter == 400)||(iter == 450)||(iter == 500)
% % %             pot_borda = potencial_borda(img_procurada);
            pot_borda_procurado = potencial_borda(img_procurada);
      
            % Resolvendo o problema inverso
            val_cor = 0.1;
            imgr = img_reconst_cond(cod_img,n_eletr,pot_borda_procurado,val_cor);
% % %             subplot(1,2,1); 
            figure;show_fem(imgr,[1,1]); axis off
% % %             title(strcat('Solu��o Procurada - erro relativo(%)', num2str(100*erro_procurado)));
            saveas(gcf,strcat('imagem_resultado_itera��o',num2str(iter),'erro relativo', num2str(erro_procurado),'.bmp'));
        
            % Plotando os potenciais de borda do individuo procurado e salvando o resultado
% % %             xax = 1:length(pot_borda.meas);
% % %             subplot(1,2,2); plot(xax,pot_borda_procurado.meas);
% % %             xlabel('Contorno da Imagem');
% % %             ylabel('Potencial El�trico');
% % %             title('solu��o procurada p�s-filtro');
% % %             dlmwrite(strcat('potenciais de borda da solu��o �tima',num2str(iter)),pot_borda_procurado.meas');            
        end
        
% % %         if iter == iter_max
% % %             iter1 = inputdlg('Novo valor m�ximo de itera��o:','OBS');
% % %             iter_max1 = str2double(iter1);
% % %         end
    
        if iter < iter_max1
            sol_encontrada = 0;
        else
            sol_encontrada = 1;
        end
    end
    
    i = i+1;
end

end

