function varargout = WCS(varargin)
% WCS MATLAB code for WCS.fig
%      WCS, by itself, creates a new WCS or raises the existing
%      singleton*.
%
%      H = WCS returns the handle to a new WCS or the handle to
%      the existing singleton*.
%
%      WCS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WCS.M with the given input arguments.
%
%      WCS('Property','Value',...) creates a new WCS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WCS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WCS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WCS

% Last Modified by GUIDE v2.5 24-Nov-2015 20:03:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WCS_OpeningFcn, ...
                   'gui_OutputFcn',  @WCS_OutputFcn, ...
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


% --- Executes just before WCS is made visible.
function WCS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WCS (see VARARGIN)

% Choose default command line output for WCS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WCS wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% -------------------------------------------------------------------
% show pic, user click Yes or No, tell if correct or not, add to score
% wait 2 seconds and then next image. When done wait then cla
% -------------------------------------------------------------------

y=0; n=0; % default yes - no answer values

for i=1:20 % there are 20 images
    file_name = [num2str(i), '.jpg'];
    im=imread(file_name);
    axes(handles.Image);
    imshow(im);


YesAns = get(hObject,'Value');
if YesAns == get(hObject,'Max')
%     if i = ismember([1, 2, 3, 4, 5, 16, 17, 18, 19, 20]),y=y+1;
%      end
    % toggle button is pressed
elseif YesAns == get(hObject,'Min')
    % toggle button is not pressed
end
guidata(hObject, handles);

NoAns = get(hObject,'Value');
if NoAns == get(hObject,'Max')
    n=n+1;
    % toggle button is pressed
elseif NoAns == get(hObject,'Min')
    % toggle button is not pressed
end
guidata(hObject, handles);

pause()
end

% --- Executes during object creation, after setting all properties.
function Image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Image


% --- Outputs from this function are returned to the command line.
function varargout = WCS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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
function RW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Score_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

