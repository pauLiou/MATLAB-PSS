function PSS_threshold = PSS_threshold(data)
addpath('C:\toolbox\psignifit-master\psignifit-master');

% run the trial_output data converter to get the percentage correct at each
% SOA
[SOAs,result_unique,SOA_unique,info] = trial_output_doris(data);

% plug the data into psychofunc
result.raw = psychofunc(info.data_raw);
% print the output
plotPsych(result.raw)

% calculate the PSS threshold (50%)
[threshold,CI] = getThreshold(result.raw,0.5,1);

% save threshold back to experiment
PSS_threshold = threshold