function [ITER,ERRO,TEMP] = comp_evol_TIE(n_ind,cod_img,n_eletr,n_ind_selec,n_elem_selec,pot_borda_obj_estudo,n_elem_cruz,perc_ruido,iter_max)
%    sol_encontrada = comp_evol_TIE(n_ind,cod_img,n_eletr,n_ind_selec,n_iter_max,n_elem_selec,erro_max,pot_borda_obj_estudo,n_elem_cruz)                  
%                                                                      
% COMP_EVOL_TIE - Programa usado para encontrar a distribui��o de condutividade el�trica de um objeto de estudo conhecida a distribui��o de
% potenciais el�tricos de borda baseando-se no Algoritmo Gen�tico
% sol_encontrada => vari�vel usada para indicar se houve ou n�o a converg�ncia
% n_ind => n� de indiv�duos da popula��o inicial
% cod_img => c�digo da imagem pelo EIDORS
%  EX.: 'a2d0c'  - modelo circular 2D usando distmesh 
%       'b2d1c'  - modelo circular 2D usando distmesh ~ 1300 elementos
%       'd2d4c'  - modelo circular 2D usando distmesh ~ 3200 elems
%      a-j => densidade de malha
%      2d  => modelo 2D Distmesh 
%      0-4 => refinamento de elementos
%      c   => malha circular
%      t2  => malha sec��o do t�rax
% n_eletr => n� de eletrodos de borda
% n_ind_selec => n�mero de indiv�duos selecionados da popula��o com melhor aptid�o
% n_iter_max => n� de itera��es m�xima para converg�ncia
% n_elem_selec => n� de elementos selecionados inicialmente para serem mutados
% erro_max => Erro relativo m�ximo inicial para converg�ncia 
% pot_borda_obj_estudo => distribui��o de potenciais el�tricos de borda do objeto de estudo
% n_elem_cruz => n� de elementos selecionados para cruzamento
% img => os indiv�duos com distribui��o interna de condutividade el�trica aleat�rio 
% n_elem => n� total de elementos da imagem do objeto de estudo discretizada
% rank_ind => vetor de erros relativos dos indiv�duos
% rank_ind_selec => vetor de erros relativos dos indiv�duos selecionados com maior aptid�o
% ind_selec => vetor formado pelas posi��es dos individuos selecionados em rela��o a todos os indiv�duos criados
% img_0 => vetor que cont�m todas as imagens de condutividade dos indiv�duos cruzados
% img_1 => vetor que contem todas as imagens de condutividade do indiv�duos mutados
% rank_ind_mutado => vetor de erro relativos dos indiv�duos mutados
% rank_ind_selec_mutado => vetor contendo os erros de todos indiv�duos selecionados e mutados 
% img_selec_mutada => vetor de imagens contendo as condutividades de todos indiv�duos selecionados, cruzados e mutados  
% perc_ruido => percentual de ruido (valor entre 0 e 1) 
% 
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 28/05/13                                             
% Data de atualiza��o: 13/06/13    


% Encontrando uma popula��o inicial
[img,n_elem] = populacao_inicial (n_ind,cod_img,n_eletr);

n_calc_erro = 0;
% Avalia��o de Aptid�o por rank de erro relativo
[rank_ind,n_calc_erro] = avaliacao_aptidao(img,n_ind,cod_img,n_eletr,pot_borda_obj_estudo,n_calc_erro);

% Alterando o erro m�ximo de converg�ncia e o n�mero de elementos mutados a medida que a intera��o chega ao seu m�ximo 
tic
sol_encontrada = 0;
iter = 1
while (sol_encontrada == 0)

    % Sele��o dos indiv�duos mais aptos
      ind_selec = selecao_ind(rank_ind,n_ind_selec);

    % Cruzamento dos indiv�duos selecionados
      [img_0,n_ind_selec_cruz] = cruzamento(ind_selec,n_ind_selec,img,n_elem,n_elem_cruz);
%       [img_0,n_ind_selec_cruz,rank_ind_cruz] = cruzamento(ind_selec,n_ind_selec,img,n_elem,n_elem_cruz,n_ind,cod_img,n_eletr,pot_borda_obj_estudo);
    
    % Muta��o dos indiv�duos selecionados
      [img_1,rank_ind_mutado,n_calc_erro] = mutacao(img_0,n_ind_selec_cruz,n_elem_selec,cod_img,n_eletr,pot_borda_obj_estudo,n_elem,perc_ruido,n_calc_erro); 
%       [img_1,rank_ind_mutado] = mutacao(img_0,n_ind_selec_cruz,n_elem_selec,cod_img,n_eletr,pot_borda_obj_estudo,n_elem,perc_ruido,rank_ind_cruz);
      
    % Crit�rio de parada
    [rank_ind_selec_mutado,img_selec_mutada,sol_encontrada,iter_max1] = criterio_parada(rank_ind_mutado,img_1,cod_img,n_eletr,iter,iter_max);
    iter_max = iter_max1;
    
    % Crando uma nova popula��o de poss�veis solu��es caso n�o convergiu
    r = length(rank_ind_selec_mutado);
    for p = 1:r
        img(p).elem_data = img_selec_mutada(p).elem_data;
    end
    rank_ind = rank_ind_selec_mutado;
    
    rank_min = min(rank_ind_selec_mutado)
    
    n_max_elem = length(img(1).elem_data);
    
    % Mostrando o comportamento do programa    
    ITER(iter) = iter;
    ERRO(iter) = min(rank_ind_selec_mutado);
    TEMP(iter) = toc/60;
    if (iter == 50)||(iter == 100)||(iter == 150)||(iter == 200)||(iter == 250)||(iter == 300)||(iter == 350)||(iter == 400)||(iter == 450)||(iter == 500)
        figure
        plot(ITER,ERRO,'*-')
% % %         title('Depend�ncia do erro de reconstru��o usando AG para o n�mero de gera��es');
        xlabel('Number of generations')
        ylabel('Relative error')
        saveas(gcf,strcat('Comportamento_do_Programa.bmp'));
    end
    
% % %     if (iter >= 2) && (ERRO(iter) == ERRO(iter-1)) && (n_ind_selec <= n_ind) 
% % %         n_ind_selec = n_ind_selec+5
% % %     end
    
    if  sol_encontrada == 0
        iter = iter+1
    end
    if sol_encontrada == 1
        num_de_calculos_de_erro = n_calc_erro
    end
end

end

    