function varargout = JW(varargin)
% JW MATLAB code for JW.fig
%      JW, by itself, creates a new JW or raises the existing
%      singleton*.
%
%      H = JW returns the handle to a new JW or the handle to
%      the existing singleton*.
%
%      JW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JW.M with the given input arguments.
%
%      JW('Property','Value',...) creates a new JW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before JW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to JW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help JW

% Last Modified by GUIDE v2.5 29-Nov-2015 15:32:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JW_OpeningFcn, ...
                   'gui_OutputFcn',  @JW_OutputFcn, ...
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


% --- Executes just before JW is made visible.
function JW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to JW (see VARARGIN)

% Choose default command line output for JW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JW wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = JW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% -------------------------------------------------------------------
% show pic, user click Yes or No, tell if correct or not, add to score
% wait 2 seconds and then next image.
% -------------------------------------------------------------------
handles.i = 38;
guidata(hObject, handles);


for i=1:20 % there are 20 images
    file_name = [num2str(i), '.jpg'];
    im=imread(file_name);
    imshow(im);
end


function ShowQuestion(handles)


end

% --- Executes on button press in same.
function same_Callback(hObject, eventdata, handles)
% hObject    handle to same (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%i = handles.i

% Hint: get(hObject,'Value') returns toggle state of same

isPushed = get(hObject,'Value');
A = [1, 2, 3, 4, 5, 16, 17, 18, 19, 20];
B = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

if isPushed == JW_OutputFcn(hObject,'Value', i);
   if i ismember (A,B);
       y=y+1;
   end
    % toggle button is pressed
end
guidata(hObject, handles);

% --- Executes on button press in different.
function different_Callback(hObject, eventdata, handles)
% hObject    handle to different (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of different



function score_Callback(hObject, eventdata, handles)
% hObject    handle to score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of score as text
%        str2double(get(hObject,'String')) returns contents of score as a double


% --- Executes during object creation, after setting all properties.
function score_CreateFcn(hObject, eventdata, handles)
% hObject    handle to score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
