function varargout = interpolation(varargin)
% INTERPOLATION MATLAB code for interpolation.fig
%      INTERPOLATION, by itself, creates a new INTERPOLATION or raises the existing
%      singleton*.
%
%      H = INTERPOLATION returns the handle to a new INTERPOLATION or the handle to
%      the existing singleton*.
%
%      INTERPOLATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERPOLATION.M with the given input arguments.
%
%      INTERPOLATION('Property','Value',...) creates a new INTERPOLATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interpolation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interpolation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interpolation


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interpolation_OpeningFcn, ...
                   'gui_OutputFcn',  @interpolation_OutputFcn, ...
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


% --- Executes just before interpolation is made visible.
function interpolation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interpolation (see VARARGIN)

% Choose default command line output for interpolation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interpolation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interpolation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global chosenMethod;
global order;
global points;
global queries;
global correspondingPoints ;
global queryPts ;

[baseName, folder] = uigetfile();
[ chosenMethod, order ,points, correspondingPoints, queryPts] = parsePart2( baseName )


switch chosenMethod
    case 1
     [ result,excution_time,fn,answers ] = newton_interpolation( (points), (correspondingPoints), (queryPts)  )
        ezplot(fn,[-100,100,-100,100]);
        hold on;
        scatter((points), (correspondingPoints));     
        tempo = double(cat(2, (queryPts).', double(answers).'));
         set(handles.functionDisplay,'String',char(fn));
        set(handles.timeDisplay,'String',(excution_time));
        set(handles.uitable1, 'columnname', {'query', 'result'});
        set(handles.uitable1,'Data',tempo);
        xL = xlim;
        yL = ylim;
        line(xL, [0 0],'color','k','linewidth',1);
        line([0 0], yL,'color','k','linewidth',1);
        zoom on;
        legend("F(X)","Points");
        hold off;        
    case 2
        [f, results,time] = LagRange( (order), (points), (correspondingPoints), (queryPts) )
        tempo = double(cat(2, (queryPts).', results.'));
        set(handles.timeDisplay,'String',(time));
        set(handles.functionDisplay,'String',char(f));
        set(handles.uitable1, 'columnname', {'query', 'result'});
        set(handles.uitable1,'Data',tempo);
        ezplot(f,[-100,100,-100,100]);
        hold on;
        scatter((points), (correspondingPoints))
        xL = xlim;
        yL = ylim;
        line(xL, [0 0],'color','k','linewidth',1);
        line([0 0], yL,'color','k','linewidth',1);
        zoom on;
        legend("F(X)","Points");
        hold off;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
%NASSER HERE PARSING POINTS AND CORRESPONDING AND ORDER POINTS 
global chosenMethod;
global order;
global points;
global queries;
global correspondingPoints ;
 x =  get(handles.edit1,'String');
 y =  get(handles.edit2,'String');
 stringquery =  get(handles.edit4,'String');

correspondingPoints=strsplit(y,',');
 
points = strsplit(x,',');
queries = strsplit(stringquery,',');
order= get(handles.edit3,'String');
chosenMethod= get(handles.text2,'String')
if(str2double(order) + 1 > length(str2double(points)) || length(str2double(points)) ~= length(str2double(correspondingPoints)))
   return; 
end
%NASSER SWITCH DEPENED ON METHOD CHOSEN
switch chosenMethod
    case "1- Newton"
     [ result,excution_time,fn,answers ] = newton_interpolation(  str2double(points), str2double(correspondingPoints), str2double(queries))
        ezplot(fn,[-100,100,-100,100]);
        hold on;
        scatter(str2double(points), str2double(correspondingPoints));     
        tempo = double(cat(2, str2double(queries).', answers.'));
         set(handles.functionDisplay,'String',char(fn));
        set(handles.timeDisplay,'String',(excution_time));
        set(handles.uitable1, 'columnname', {'query', 'result'});
        set(handles.uitable1,'Data',tempo);
        xL = xlim;
        yL = ylim;
        line(xL, [0 0],'color','k','linewidth',1);
        line([0 0], yL,'color','k','linewidth',1);
        zoom on;
        legend("F(X)","Points");
        hold off;
    case "2-Larange"
         [f, results,time] = LagRange( str2double(order), str2double(points), str2double(correspondingPoints), str2double(queries) )
        tempo = double(cat(2, str2double(queries).', results.'));
        set(handles.timeDisplay,'String',(time));
        set(handles.functionDisplay,'String',char(f));
        set(handles.uitable1, 'columnname', {'query', 'result'});
        set(handles.uitable1,'Data',tempo);
        ezplot(f,[-100,100,-100,100]);
        hold on;
        scatter(str2double(points), str2double(correspondingPoints))
        xL = xlim;
        yL = ylim;
        line(xL, [0 0],'color','k','linewidth',1);
        line([0 0], yL,'color','k','linewidth',1);
        zoom on;
        legend("F(X)","Points");
        hold off;
end

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
index = get(hObject,'Value');
list = get(hObject,'String');
method = list{index}; 
set(handles.text2,'String',method);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function functionDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to functionDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of functionDisplay as text
%        str2double(get(hObject,'String')) returns contents of functionDisplay as a double


% --- Executes during object creation, after setting all properties.
function functionDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to functionDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timeDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to timeDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeDisplay as text
%        str2double(get(hObject,'String')) returns contents of timeDisplay as a double


% --- Executes during object creation, after setting all properties.
function timeDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
