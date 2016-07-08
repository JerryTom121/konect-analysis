%
% Computer effective diameter. 
%
% PARAMETERS 
%	$network
%	$percentile   (between 1 and 99)
%
% INPUT 
%	dat/hopdistr2.$network
%
% OUTPUT 
%	dat/statistic.diameff$percentile.$network
%

network = getenv('network'); 

percentile_text = getenv('percentile'); 
percentile = str2double(percentile_text);
if isnan(percentile)
    fprintf(2, '*** Invalid percentile\n');
    exit(1);
end

% Sanity check:  if the percentile is in the range [0...1], then that
% likely is an error. 
assert(percentile > 1 && percentile < 100);

data = load(sprintf('dat/hopdistr2.%s', network));

x = konect_diameff(data, percentile / 100)

assert(length(x) == 1); 

save(sprintf('dat/statistic.diameff%s.%s', percentile_text, network), 'x', '-ascii');
