function [] = ber_per_over_snr_plot_sim()

    % Only plot the obtained simulations results, not the theoretical
    % values

    clear all;
    close all;
    
    load('results/var_all.mat');
    
    % PCC
    ber = n_bits_PCC_error./n_bits_PCC_sent;
    per = n_packets_PCC_error./n_packets_PCC_sent;
    ber_per_over_snr_plot_for_one_mcs("PCC", mcs, snr_db, ones(size(bps))*2, ones(size(tbs))*tx.config.PLCF_type*40, ber, per);
    
    % PDC
    ber = n_bits_PDC_error./n_bits_PDC_sent;
    per = n_packets_PDC_error./n_packets_PDC_sent;
    ber_per_over_snr_plot_for_one_mcs("PDC", mcs, snr_db, bps, tbs, ber, per);
end

function [] = ber_per_over_snr_plot_for_one_mcs(prefix, mcs, snr_db, bps, tbs, ber, per)

    % plot configuration
    colors = [0,      0.4470, 0.7410;...
              0.8500, 0.3250, 0.0980;...
              0.9290, 0.6940, 0.1250;...
              0.4940, 0.1840, 0.5560;...
              0.4660, 0.6740, 0.1880;...
              0.3010, 0.7450, 0.9330;...
              0.6350, 0.0780, 0.1840;...
              0.6350, 0.0780, 0.1840;...
              0.6350, 0.0780, 0.1840;...
              0.6350, 0.0780, 0.1840;...
              0.6350, 0.0780, 0.1840;...
              0.6350, 0.0780, 0.1840;...
              0.6350, 0.0780, 0.1840;...
              0.6350, 0.0780, 0.1840];
    legend_font_size = 8;
    marker_size = 4;
    axis_lim = [-0 20 1e-7 1e1];
    legend_location = 'NorthEast';

    % K-factor of Rician channel
    K = db2pow(9.0);
  
    % PER
    figure()
    clf()
    for cnt = 1:1:numel(mcs)
        str = append('MCS=', num2str(mcs(cnt)), ', TBS=', num2str(tbs(cnt)));
        semilogy(snr_db, per(cnt,:),'-o','DisplayName',str, 'Color', colors(cnt, :), 'MarkerSize', marker_size, 'MarkerFaceColor', colors(cnt, :));
        hold on
    end

    title(prefix)
    xlabel('SNR (dB)')
    ylabel('PER')
    legend('Location',legend_location, 'FontSize', legend_font_size)
    grid on
    axis(axis_lim)
    set(gca, 'ColorOrder', jet(100))
    savefig("results/" + prefix + "_PER_SNR.fig")
end

