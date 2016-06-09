
cod_img = 'b2d2c'; val_cond = 5; n_ind = 100; n_ind_selec = 10; n_elem_selec = 100; n_elem_cruz = 150; perc_ruido = 0.05; iter_max = 500;
n_eletr = 16;

% Iniciando o EIDORS
run /path/to/eidors/startup.m

pot_borda_obj_estudo = obj_estudo(cod_img, n_eletr, val_cond);

[ITER,ERRO,TEMP] = comp_evol_TIE(n_ind,cod_img,n_eletr,n_ind_selec,n_elem_selec,pot_borda_obj_estudo,n_elem_cruz,perc_ruido,iter_max);

Mat_iter_temp_erro = [ITER' TEMP' ERRO'];

save Mat_iter_temp_erro