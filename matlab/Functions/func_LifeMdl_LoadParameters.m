function lifeMdl = func_LifeMdl_LoadParameters(battery_chemistry)
switch battery_chemistry
    case 'NMC|Gr'
        lifeMdl.model = 'NMC|Gr';
        % battery life model parameters
        lifeMdl.ref          = 'NREL/K. Smith et al. American Control Conference, 2017';
        lifeMdl.description  = 'Model fit to 13 aging conditions for Kokam 75Ah cell. Data collected by NREL';
        lifeMdl.chemistry    = 'Graphite negative electrode, Ni-Mn-Co (NMC) positive electrode';
        lifeMdl.names_states = {...
            'dq_LLI_t:   Delta relative capacity-Li loss due to SEI growth, time dependent';...
            'dq_LLI_EFC: Delta relative capacity-Li loss due to SEI growth, charge-throughput dependent';...
            'dq_LAM:     Delta relative capacity-Electrode damage and lithium plating, charge-throughput dependent';...
            'dr_LLI_t:   Delta relative resistance-SEI growth, time dependent';...
            'dr_LLI_EFC: Delta relative resistance-SEI growth, charge-throughput dependent';...
            'dr_LAM:     Delta relative resistance-Electrode damage and lithium plating, charge-throughput dependent'};
        lifeMdl.names_outputs= {...
            'q:                   relative discharge capacity at C/5 rate (5 hour discharge)';...
            'qLoss_LLI:           relative capacity loss due to SEI growth';...
            'qLoss_LLI_t:         relative capacity loss due to SEI growth, time dependent';...
            'qLoss_LLI_t_LLI_EFC: relative capacity loss due to SEI growth, charge-throughput dependent';...
            'qLoss_LLI_t_LAM:     relative capacity loss due to electrode damage and lithium plating, charge-throughput dependent';...
            'r:                   relative DC pulse resistance';...
            'rGain_LLI:           relative resistance gain due to SEI growth';...
            'rGain_LLI_t:         relative resistance gain due to SEI growth, time dependent';...
            'rGain_LLI_EFC:       relative resistance gain due to SEI growth, charge-throughput dependent';...
            'rGain_LAM:           relative resistance gain due to electrode damage and lithium plating, charge-throughput dependent'};

        lifeMdl.n_states = 6;      % number of states in model that are integrated with time or cycles
        lifeMdl.n_outputs= 10;      % number of outputs in model

        % Model parameters
        lifeMdl.q1_0 = 2.66e7;
        lifeMdl.q1_1 = -17.8;
        lifeMdl.q1_2 = -5.21;
        lifeMdl.q2 = 0.357;
        lifeMdl.q3_0 = 3.80e3;
        lifeMdl.q3_1 = -18.4;
        lifeMdl.q3_2 = 1.04;
        lifeMdl.q4 = 0.778;
        lifeMdl.q5_0 = 1e4;
        lifeMdl.q5_1 = 153;
        lifeMdl.p_LAM = 10;
        lifeMdl.r1 = 0.0570;
        lifeMdl.r2 = 1.25;
        lifeMdl.r3 = 4.87;
        lifeMdl.r4 = 0.712;
        lifeMdl.r5 = -0.08;
        lifeMdl.r6 = 1.09;
    case 'LFP|Gr'
        % Life model information
        lifeMdl.model = 'LFP|Gr';
        lifeMdl.names_states = {...
            'dqCal: time dependent capacity loss',...
            'dqCyc: energy-throughput dependent capacity loss',...
            'drCal: time dependent resistance growth',...
            'drCyc: energy-throughput dependent resistance growth'};
        lifeMdl.names_outputs= {...
            'q: Relative capacity',...
            'qLossCal: Time dependent capacity loss',...
            'qLossCyc: Energy-throughput dependent capacity loss',...
            'r: Relative resistance',...
            'rGainCal: Time dependent resistance growth',...
            'rGainCyc: Energy-throughput dependent resistance growth',...
            };
        lifeMdl.n_states = 4;      % number of states in model that are integrated with time or cycles
        lifeMdl.n_outputs= 6;      % number of outputs in model

        % Instantiate parameter table
        pVars = {'p1','p2','p3','pcal','p4','p5','p6','pcyc'};
        p = [798.352102069967,-3781.20591728016,-2.04881543271387,0.494361078068684,0.000170691091574341,0.000476715369722458,0.00217277383391531,0.439274000189976];
        p = array2table(p, 'VariableNames', pVars);
        lifeMdl.p = p;

        %         pvars_rdc = {'r1','r2','r3','rcal','r4','r5','r6','rcyc'};
        p_rdc = [537306.726059759,-6747.41305124106,-1.66987638954611,0.994115565719101,4.64136140815756e-08,-5.79557082332511e-11,7.28339782547118e-06,0.931662358013465];
        p_rdc = array2table(p_rdc, 'VariableNames', pVars);
        lifeMdl.p_rdc = p_rdc;
end
end