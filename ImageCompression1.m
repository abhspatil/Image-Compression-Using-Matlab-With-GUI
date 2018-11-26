function varargout = ImageCompression1(varargin)
% IMAGECOMPRESSION1 MATLAB code for ImageCompression1.fig
%      IMAGECOMPRESSION1, by itself, creates a new IMAGECOMPRESSION1 or raises the existing
%      singleton*.
%
%      H = IMAGECOMPRESSION1 returns the handle to a new IMAGECOMPRESSION1 or the handle to
%      the existing singleton*.
%
%      IMAGECOMPRESSION1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGECOMPRESSION1.M with the given input arguments.
%
%      IMAGECOMPRESSION1('Property','Value',...) creates a new IMAGECOMPRESSION1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageCompression1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageCompression1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageCompression1

% Last Modified by GUIDE v2.5 15-Oct-2014 22:20:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageCompression1_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageCompression1_OutputFcn, ...
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


% --- Executes just before ImageCompression1 is made visible.
function ImageCompression1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageCompression1 (see VARARGIN)

% Choose default command line output for ImageCompression1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
guidata(hObject, handles);
set(handles.axes1,'visible','off')
set(handles.axes2,'visible','off')
axis off
axis off
% UIWAIT makes ImageCompression1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageCompression1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_name;
%guidata(hObject,handles)
file_name=uigetfile({'*.bmp;*.jpg;*.png;*.tiff;';'*.*'},'Select an Image File');
fileinfo = dir(file_name);
SIZE = fileinfo.bytes;
Size = SIZE/1024;
set(handles.text7,'string',Size);
imshow(file_name,'Parent', handles.axes1)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_name;
if(~ischar(file_name))
   errordlg('Please select Images first');
else
    disp(file_name);

    f1=@(block_struct)dct2(block_struct.data);
    f2=@(block_struct)idct2(block_struct.data);

    im=imread(file_name);
    
    figure 
    imshow(im)
    
    imwrite(im,'GrayScale.jpg');
    im=rgb2gray(im);

    figure
    imshow(im);

    j=blockproc(im,[8,8],f1);
    depth=find(abs(j)<150);
    j(depth)=zeros(size(depth));
    k=blockproc(j,[8,8],f2)/255;

    figure
    imshow(k);
    %disp(k);

    imwrite(k,'New_Compreesed.jpg');
    compression_ratio=numel(j)/numel(depth);
    disp(compression_ratio);
    
    fileinfo = dir('New_Compreesed.jpg');
    SIZE = fileinfo.bytes;
    Size = SIZE/1024;
    set(handles.text8,'string',Size);
     set(handles.text13,'string',compression_ratio);
    imshow(L,'Parent', handles.axes2);
end
