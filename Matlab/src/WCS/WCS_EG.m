function varargout = WCS_EG(varargin)
%WCS_EG M-file for WCS_EG.fig
%      WCS_EG, by itself, creates a new WCS_EG or raises the existing
%      singleton*.
%
%      H = WCS_EG returns the handle to a new WCS_EG or the handle to
%      the existing singleton*.
%
%      WCS_EG('Property','Value',...) creates a new WCS_EG using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to WCS_EG_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      WCS_EG('CALLBACK') and WCS_EG('CALLBACK',hObject,...) call the
%      local function named CALLBACK in WCS_EG.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WCS_EG

% Last Modified by GUIDE v2.5 22-Nov-2015 22:51:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WCS_EG_OpeningFcn, ...
                   'gui_OutputFcn',  @WCS_EG_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before WCS_EG is made visible.
function WCS_EG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for WCS_EG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WCS_EG wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% -------------------------------------------------------------------
% show pic, user click Yes or No, tell if correct or not, add to score
% wait 2 seconds and then next image. When done wait then cla

Y=0; N=0; % initial score values




% A1=imread ('1.jpg'); % initial image
% axes(handles.PicBox);
% imshow(A1);
% pause(1);

% --- Executes during object creation, after setting all properties.
function PicBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PicBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate PicBox

% --- Outputs from this function are returned to the command line.
function varargout = WCS_EG_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
 function CorNo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CorNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in YesAns.
function YesAns_Callback(hObject, eventdata, handles)
% hObject    handle to YesAns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of YesAns


% --- Executes on button press in NoAns.
function NoAns_Callback(hObject, eventdata, handles)
% hObject    handle to NoAns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NoAns


% --- Executes during object creation, after setting all properties.
function Score_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% for i=1:19 % there are 19 more images
%     file_name = [num2str(i), '.jpg'];
%     im=imread(file_name);
%     imshow(im);
% 
% A1=imread ('im'); % next image
% axes(handles.PicBox);
% imshow(A1);
% pause(1);

% a= str2num(get(handles.YesAns,'String'));
%     if (a>=0)&& (i =(1, 2, 3, 4, 5, 16, 17, 18, 19, 20));%ismember(3, [2, 3, 4])
%         Y=Y+1;
%         set (num2str(handles.CorNo, 'Correct'));
%     else
%         N=N+1;
%         set (num2str(handles.CorNo,'String', 'Incorrect'));
%     end
%     show = (str2num(Y));
%     set (handles.Score,'String',show);
%     pause(2);
% end
for i=1:20 % there are 20 images
    file_name = [num2str(i), '.jpg'];
    im=imread(file_name);
%   imshow(im);
% A1=imread ('im'); % next image
axes(handles.PicBox);
imshow(im);
pause(1);
end