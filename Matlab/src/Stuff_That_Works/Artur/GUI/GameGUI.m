function varargout = GameGUI(varargin)
% GAMEGUI MATLAB code for GameGUI.fig
%      GAMEGUI, by itself, creates a new GAMEGUI or raises the existing
%      singleton*.
%
%      H = GAMEGUI returns the handle to a new GAMEGUI or the handle to
%      the existing singleton*.
%
%      GAMEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAMEGUI.M with the given input arguments.
%
%      GAMEGUI('Property','Value',...) creates a new GAMEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GameGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GameGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GameGUI

% Last Modified by GUIDE v2.5 21-Oct-2015 14:58:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GameGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GameGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GameGUI is made visible.
function GameGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GameGUI (see VARARGIN)

% Choose default command line output for GameGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GameGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

GameInfo.decreaseRatio = 0.85;
GameInfo.errorTolerance = 0.05;
GameInfo.timeLimitPerTaget = 20;
handles.GameInfo.user = [];
handles.GameInfo.error = [];

handles.GameInfo = GameInfo;
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GameGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axisMain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axisMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axisMain
hObject.XLim = [0 1];
hObject.YLim = [0 1];


% --- Executes on button press in btnStart.
function btnStart_Callback(hObject, eventdata, handles)
% hObject    handle to btnStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

userinput = inputdlg('Please enter your name: ');

if(isempty(userinput))
    return;
end

username = userinput{1};

cla

numTarget = handles.btngrpNumTarget.UserData;

totalError = 0;
initialMarkerSize = 10;


decreaseRatio = handles.GameInfo.decreaseRatio;
errorTolerance = handles.GameInfo.errorTolerance;
timeLimit = handles.GameInfo.timeLimitPerTaget * numTarget;

% Generate 6 random locations
x  = rand(1, numTarget);
y  = rand(1, numTarget);

% Variable to check if the time limit is over
timeLimitOver = false;

hold on;
tic 
for tr = 1:numTarget
    
    % Reduce the marker size and error tolerance in each iteration
    markerSize = initialMarkerSize * decreaseRatio ^ (tr-1);
    errorTolerance = errorTolerance * decreaseRatio ^ (tr-1);    
    
    % Plot the new target
    plot(x(tr), y(tr), 'ob', 'MarkerSize', markerSize);    
    hit = false;
    
    while(~hit)
       % Get user clocked location
       [ix, iy] = ginput(1);       
       
       duration = toc;
       % Check if the time limit is over. If yes, the game is over
       if(duration > timeLimit)
            str = sprintf('Sorry %s! The time limit for this game has already been over! \n', username);
            title(str);
            
            timeLimitOver = true;
            
            break; % Jump out of the while loop
       end
       
       distance = sqrt((x(tr) - ix)^2 + (y(tr) - iy)^2);
       
       % Check if distance is less than the error tolerance 
       if(distance < errorTolerance)
           plot(x(tr), y(tr), 'xr', 'MarkerSize', 10);
           hit = true;
       else
           plot(ix, iy, 'xr', 'MarkerSize', 5);
           totalError = totalError + distance;
       end
    end  
    
    % If the time limit is over, jump out of the for loop. No new target
    % will be shown.
    if(timeLimitOver)
        break; 
    end    
end


if(~timeLimitOver)
    str = sprintf('%s, your total error for this game is %.3f and you finished the game in %.3f seconds! \n', username, totalError, duration);
    title(str);
    
    handles.GameInfo.user = username;
    handles.GameInfo.error = totalError;
    guidata(hObject, handles);
    
end


% --- Executes when selected object is changed in btngrpNumTarget.
function btngrpNumTarget_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btngrpNumTarget 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.btngrpNumTarget.UserData = hObject.UserData;


% --- Executes during object creation, after setting all properties.
function btngrpNumTarget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btngrpNumTarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

hObject.UserData = 3;


% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuTools_Callback(hObject, eventdata, handles)
% hObject    handle to menuTools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSettings_Callback(hObject, eventdata, handles)
% hObject    handle to menuSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Time limit per target: ', 'Error tolerance:', 'Decrease ratio:'}; 
dlg_title = 'Settings';
num_lines = 1;
defaultans = {num2str(handles.GameInfo.timeLimitPerTaget), num2str(handles.GameInfo.errorTolerance), num2str(handles.GameInfo.decreaseRatio)};
userinput = inputdlg(prompt,dlg_title,num_lines,defaultans);

if(~isempty(userinput))
    
    handles.GameInfo.timeLimitPerTaget = str2num(userinput{1});
    handles.GameInfo.errorTolerance = str2num(userinput{2});
    handles.GameInfo.decreaseRatio = str2num(userinput{3});
    guidata(hObject, handles);

end


% --------------------------------------------------------------------
function menuScores_Callback(hObject, eventdata, handles)
% hObject    handle to menuScores (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gameScore = load('GameScoreFile');
    
names = gameScore.names;
errors = gameScore.errors;

[errors, indices] = sort(errors);
names = names(indices);

msgStr = '';
for i = 1:numel(names)
    str = sprintf('%s : %f \n', names{i}, errors(i));
    msgStr = [msgStr, str];
end

msgbox(msgStr);



% --------------------------------------------------------------------
function menuSave_Callback(hObject, eventdata, handles)
% hObject    handle to menuSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(~isempty(handles.GameInfo.user))

    gameScore = load('GameScoreFile');
    
    names = gameScore.names;
    errors = gameScore.errors;

    % Add the name and the error for the currenct user to the lists
    names{end+1} = handles.GameInfo.user;
    errors(end+1) = handles.GameInfo.error;

    save GameScoreFile names errors;
    msgbox('Your score was saved.');
end


% --------------------------------------------------------------------
function menuExit_Callback(hObject, eventdata, handles)
% hObject    handle to menuExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
