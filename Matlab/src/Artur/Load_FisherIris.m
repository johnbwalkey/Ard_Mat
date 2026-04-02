function prediction =nearestN(meas, species, newMeas)
clc
% load fisheriris % as example
% calc distance between NewMeas and others
% find the flower from meas which is the closest to newMeas
% predict the new flower ot flower's  class
% can use qscatter in Command window for both htyese scatters

scatter (meas(:,1), meas(:,2))
scatter (meas(:,1), meas(:,2), species)

end