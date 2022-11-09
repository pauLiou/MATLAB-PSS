function [SOAs, result, SOA_unique,info] = trial_output_doris(data)

result = data(:,4) == data(:,3);
result = result';

SOAs = data(:,6)';
SOA_unique = unique(SOAs);

info.nCorrect = zeros(1,length(SOA_unique)); % number of correct trials per SOA
info.nTrials = zeros(1,length(SOA_unique)); % number of trials at each SOA

% fills in the nCorrect and nTrials data based on the SOA and result data
for i = 1:length(SOA_unique)
    id = (SOAs == SOA_unique(i)) & ~isnan(result);
    info.nTrials(i) = sum(id);
    info.nCorrect(i) = sum(result(id));
end

% calculates percentage correct
info.pCorrect = info.nCorrect./info.nTrials;

% invert axis
info.pCorrect = info.pCorrect';
info.nCorrect = info.nCorrect';
info.nTrials = info.nTrials';

% the percentage correct with the SOAs
info.pCorrect_data = [info.pCorrect,SOA_unique'];

info.data_raw = [SOA_unique', info.nCorrect, info.nTrials];

end