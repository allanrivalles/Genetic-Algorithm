function [rank_ind_selec_mutado,img_selec_mutada,sol_encontrada,iter_max1] = criterio_parada(rank_ind_mutado,img_1,cod_img,n_eletr,iter,iter_max)
%  [rank_ind_selec_mutado,img_selec_mutada,sol_encontrada] = criterio_parada(pot_borda_obj_estudo,rank_ind_selec,rank_ind_mutado,n_ind_selec,img,img_1,erro_max,ind_selec,cod_img,n_eletr)                  
%                                                                      
% CRITERIO_PARADA - Procura o indivíduo que tenho erro relativo menor que o erro máximo    
% rank_ind_selec_mutado => vetor contendo os erros de todos indivíduos selecionados e mutados 
% img_selec_mutada => vetor de imagens contendo as condutividades de todos indivíduos selecionados, cruzados e mutados  
% sol_encontrada => uma váriavel usada para indicar se houve ou não a convergência
% pot_borda_obj_estudo => Distribuição de potenciais elétricos na borda do objeto de estudo (procurado)
% rank_ind_selec => vetor contendo os erros de todos indivíduos selecionados
% rank_ind_mutado => vetor contendo os erros de todos indivíduos mutados
% n_ind_selec => nº de indivíduos selecionados
% img => vetor contendos indivíduos com distribuição interna de condutividade elétrica aleatório
% img_1 => vetor que contem todas as imagens de condutividade do indivíduos mutados
% erro_max => erro máximo para convergência
% ind_selec => vetor formado pelas posições dos individuos selecionados em relação a todos os indivíduos criados
% cod_img => código da imagem pelo EIDORS
% n_eletr => nº de eletrodos de borda
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Graduação em Eng. Biomédica - CTG / UFPE                     
% Data de criação: 28/05/13                                             
% Data de atualização: 13/06/13    

% Criando um vetor com os erros (EQM) dos indivíduos selecionados (pais) e mutados (filhos)
rank_ind_selec_mutado = [rank_ind_mutado];
n_ind_selec_mutado = length(rank_ind_mutado);

% Criando um vetor de imagens dos indivíduos selecionados (pais) e mutados (filhos)
imax = n_ind_selec_mutado;
for j = 1:imax
    img_selec_mutada(j).elem_data = img_1(j).elem_data;
end

% Ordenando de forma crescente o vetor de erro (EQM) dos indivíduos selecionados (pais) e mutados (filhos)
rank_ind_selec_mut_ordenado = sort(rank_ind_selec_mutado,'ascend');
erro_min_now = rank_ind_selec_mut_ordenado(1);

% Fazendo a convergência, convergindo quando sol_encontrada = 1
iter_max1 = iter_max;
sol_encontrada = 0;
i = 1;
while (sol_encontrada ~= 1) && (i <= imax)
    if (rank_ind_selec_mutado(i) == rank_ind_selec_mut_ordenado(1))
        erro_procurado = rank_ind_selec_mut_ordenado(1);
        rank_ind_mel = rank_ind_selec_mutado(i);

        % Imagem de distribuição de condutividade elétrica procurada
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
% % %             title(strcat('Solução Procurada - erro relativo(%)', num2str(100*erro_procurado)));
            saveas(gcf,strcat('imagem_resultado_iteração',num2str(iter),'erro relativo', num2str(erro_procurado),'.bmp'));
        
            % Plotando os potenciais de borda do individuo procurado e salvando o resultado
% % %             xax = 1:length(pot_borda.meas);
% % %             subplot(1,2,2); plot(xax,pot_borda_procurado.meas);
% % %             xlabel('Contorno da Imagem');
% % %             ylabel('Potencial Elétrico');
% % %             title('solução procurada pós-filtro');
% % %             dlmwrite(strcat('potenciais de borda da solução ótima',num2str(iter)),pot_borda_procurado.meas');            
        end
        
% % %         if iter == iter_max
% % %             iter1 = inputdlg('Novo valor máximo de iteração:','OBS');
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

