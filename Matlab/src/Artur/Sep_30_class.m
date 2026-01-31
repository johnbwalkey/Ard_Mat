% get input from Mouse

% first create figure
figure; hold on
xlim([0 1]) % get x axis
ylim ([0 1]) % get Y axis

[x y ]= ginput (1) % graphiocsal input
% when you click on plot get values assigned to x & y

% what about want a mark on plot where clicked on
plot (x,y, 'o')

% to repeat 3 times
for i=1:3
    [x y ]= ginput (1) % ginput allows you to specify how many 
                    % clicks to remember - so 2 means click twice to mark
    plot (x,y, 'o')
end

return


%% to read data from Excel file - use xlread

mn=xlsread('excel_temp_data')
op=mn
op=xlswrite('excel_temp_jw.xlsx')


% image read
img=imread('brain_im.jpg')
% show image - ie display
figure; imagesc(img)

%if just want to display reed channel
figure; imagesc(img(:,:,2)); hold on


%% exampple of 3-D things
r=rand(10,20);
figure; imagesc(r)

% click on legend button on graph window
% also can rotate from toolbar



