%Script to make combined bar plot of standard deviation of turnover fluxes for both space and time
%
%Dependencies
%-global_turn_frac_sd.m
%-global_turn_frac_sd_time.m
%And dependencies within dependencies
%-get_stocks_fluxes.m
%-get_closed_can_mask.m
%-get_forest_type.m
%
%T. Pugh
%23.02.18

makeplots=false; %Make plots with the function below (true) or just the combined one (false)

%Location of *.mat files containing preprocessed model data
data_models='/Users/pughtam/Documents/GAP_and_other_work/Mortality/mat_files/';
%Location of netcdf files containing closed canopy forest mask
data_mask='/Users/pughtam/data/turnover/';
%Forest type files calculated using scripts in 'model_masks' directory
data_phen='/data/turnover/masks/phen/';

[lrrflux_mask_std,mflux_mask_std,lrrflux_mask_std_biom,mflux_mask_std_biom...
    ,~,~]=global_turn_frac_sd(makeplots,data_models,data_mask,data_phen);

[lrrflux_mask_std_mean,mflux_mask_std_mean,lrrflux_mask_std_mean_biom,...
    mflux_mask_std_mean_biom,phen_label,nphen]=...
    global_turn_frac_sd_time(makeplots,data_models,data_mask,data_phen);

models={'CABLE-POP','JULES','LPJ-GUESS','LPJmL','ORCHIDEE','SEIB-DGVM'};

figure
subplot(2,1,1)
bb=bar([mflux_mask_std,lrrflux_mask_std]);
set(gca,'XTickLabel',models)
for nn=1:2
    set(bb(nn),'LineStyle','none')
end
clear nn
legend('Mortality','Phenology')
ylabel('\sigma_{space} (kg C m^{-2} a^{-1})')
set(gca,'YLim',[0 0.4])
set(gca,'XLim',[0.5 6.5])
t1=text(0.7,0.35,'(a)');
set(t1,'FontSize',12,'FontWeight','Bold')

subplot(2,1,2)
bb=bar([mflux_mask_std_mean,lrrflux_mask_std_mean]);
set(gca,'XTickLabel',models)
for nn=1:2
    set(bb(nn),'LineStyle','none')
end
clear nn
ylabel('\sigma_{time} (kg C m^{-2} a^{-1})')
set(gca,'YLim',[0 0.4])
set(gca,'XLim',[0.5 6.5])
t2=text(0.7,0.35,'(b)');
set(t2,'FontSize',12,'FontWeight','Bold')
