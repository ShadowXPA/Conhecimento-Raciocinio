function varargout = alineaE(varargin)
% ALINEAE MATLAB code for alineaE.fig
%      ALINEAE, by itself, creates a new ALINEAE or raises the existing
%      singleton*.
%
%      H = ALINEAE returns the handle to a new ALINEAE or the handle to
%      the existing singleton*.
%
%      ALINEAE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALINEAE.M with the given input arguments.
%
%      ALINEAE('Property','Value',...) creates a new ALINEAE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before alineaE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to alineaE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help alineaE

% Last Modified by GUIDE v2.5 16-Jun-2021 20:33:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @alineaE_OpeningFcn, ...
    'gui_OutputFcn',  @alineaE_OutputFcn, ...
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


% --- Executes just before alineaE is made visible.
function alineaE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to alineaE (see VARARGIN)

% Choose default command line output for alineaE
handles.output = hObject;


set(handles.uitable1,'ColumnName',[{'Alpha'},{'Beta'},...
    {'Gamma'}, {'Epsilon'}, {'Eta'}, {'Theta'},...
    {'Pi'}, {'Rho'}, {'Psi'}, {'Omega'}]);

iteracoes = 1000;
layers = [10];
transferFcnHidden = 'tansig';
transferFcn = 'purelin';
trainFcn = 'traingdx';
divideFcn = '';
divParamTreino = 0.8;
divParamVal = 0.1;
divParamTeste = 0.1;

handles.net = feedforwardnet(layers);

% Função de ativação
for i = 1 : size(layers, 2)
    handles.net.layers{i}.transferFcn = transferFcnHidden;
end
tmp = size(layers, 2) + 1;
handles.net.layers{tmp}.transferFcn = transferFcn;

% Função de treino
handles.net.trainFcn = trainFcn;

% Número de épocas
handles.net.trainParam.epochs = iteracoes;

% Divisão de exemplos
handles.net.divideFcn = divideFcn;
if (~isempty(divideFcn))
    handles.net.divideParam.trainRatio = divParamTreino;
    handles.net.divideParam.valRatio = divParamVal;
    handles.net.divideParam.testRatio = divParamTeste;
end

str = string(strjoin(["" layers transferFcnHidden transferFcn trainFcn divideFcn divParamTreino divParamVal divParamTeste]));
set(handles.textRede, 'String', str);
set(handles.textTotal, 'String', "");

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes alineaE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = alineaE_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editIter_Callback(hObject, eventdata, handles)
% hObject    handle to editIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIter as text
%        str2double(get(hObject,'String')) returns contents of editIter as a double


% --- Executes during object creation, after setting all properties.
function editIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHidden.
function popHidden_Callback(hObject, eventdata, handles)
% hObject    handle to popHidden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHidden contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHidden


% --- Executes during object creation, after setting all properties.
function popHidden_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHidden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popTreino.
function popTreino_Callback(hObject, eventdata, handles)
% hObject    handle to popTreino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popTreino contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popTreino


% --- Executes during object creation, after setting all properties.
function popTreino_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popTreino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popDiv.
function popDiv_Callback(hObject, eventdata, handles)
% hObject    handle to popDiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popDiv contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popDiv


% --- Executes during object creation, after setting all properties.
function popDiv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popDiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTreino_Callback(hObject, eventdata, handles)
% hObject    handle to editTreino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTreino as text
%        str2double(get(hObject,'String')) returns contents of editTreino as a double


% --- Executes during object creation, after setting all properties.
function editTreino_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTreino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MyUpdate(hObject, handles, 1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MyUpdate(hObject, handles, 2);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MyUpdate(hObject, handles, 3);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MyUpdate(hObject, handles, 4);


function editNN_Callback(hObject, eventdata, handles)
% hObject    handle to editNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNN as text
%        str2double(get(hObject,'String')) returns contents of editNN as a double


% --- Executes during object creation, after setting all properties.
function editNN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInputs_Callback(hObject, eventdata, handles)
% hObject    handle to editInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInputs as text
%        str2double(get(hObject,'String')) returns contents of editInputs as a double


% --- Executes during object creation, after setting all properties.
function editInputs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRegex_Callback(hObject, eventdata, handles)
% hObject    handle to editRegex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRegex as text
%        str2double(get(hObject,'String')) returns contents of editRegex as a double


% --- Executes during object creation, after setting all properties.
function editRegex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRegex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVal_Callback(hObject, eventdata, handles)
% hObject    handle to editVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVal as text
%        str2double(get(hObject,'String')) returns contents of editVal as a double


% --- Executes during object creation, after setting all properties.
function editVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTeste_Callback(hObject, eventdata, handles)
% hObject    handle to editTeste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTeste as text
%        str2double(get(hObject,'String')) returns contents of editTeste as a double


% --- Executes during object creation, after setting all properties.
function editTeste_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTeste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popOutput.
function popOutput_Callback(hObject, eventdata, handles)
% hObject    handle to popOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popOutput contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popOutput


% --- Executes during object creation, after setting all properties.
function popOutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editCamadas_Callback(hObject, eventdata, handles)
% hObject    handle to editCamadas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCamadas as text
%        str2double(get(hObject,'String')) returns contents of editCamadas as a double


% --- Executes during object creation, after setting all properties.
function editCamadas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCamadas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MyUpdate(hObject, handles, opcao)
fileNN = get(handles.editNN, 'String');

fileInputs = get(handles.editInputs, 'String');
fileRegex = get(handles.editRegex, 'String');

switch (opcao)
    case (1)
        % Carregar NN
        if (~isempty(fileNN))
            load(fileNN, 'net');
            handles.net = net;
            
            layers = net.layers;
            transferFcnHidden = net.layers{1}.transferFcn;
            transferFcn = net.layers{size(layers, 2) + 1}.transferFcn;
            trainFcn = net.trainFcn;
            divideFcn = net.divideFcn;
            if (~isempty(divideFcn))
                divParamTreino = net.divideParam.trainRatio;
                divParamVal = net.divideParam.valRatio;
                divParamTeste = net.divideParam.testRatio;
            else
                divParamTreino = 0;
                divParamVal = 0;
                divParamTeste = 0;
            end
            
            str = string(strjoin(["" net.layers(1:end-1).dimensions' transferFcnHidden transferFcn trainFcn divideFcn divParamTreino divParamVal divParamTeste]));
            set(handles.textRede, 'String', str);
            set(handles.textTotal, 'String', "");
            
            fprintf("Rede carregada!\n");
            guidata(hObject, handles);
        end
    case (2)
        % Gravar NN
        if (isfield(handles, 'net'))
            % Gravar rede
            if (~isempty(fileNN))
                net = handles.net;
                save(fileNN, 'net');
                fprintf("Rede guardada!\n");
            end
        else
            errordlg('Rede neuronal não existe!', 'Erro!', 'modal');
        end
    case (3)
        % Treinar NN
        set(handles.textTotal, 'String', "");
        set(handles.uitable1, 'Data', cell(size(get(handles.uitable1,'Data'))));
        [imageInput, imageTarget] = GetImages(fileInputs, fileRegex, get(handles.checkInverted, 'Value'));
        [handles.net, ~] = train(handles.net, imageInput, imageTarget);
        % textRede
        guidata(hObject, handles);
        fprintf("Rede treinada!\n");
    case (4)
        % Testar NN
        if (isfield(handles, 'net'))
            [imageInput, imageTarget] = GetImages(fileInputs, fileRegex, get(handles.checkInverted, 'Value'));
            y = sim(handles.net, imageInput);
            accuracy = CalculateAccuracy(y, imageTarget);
            fprintf("Precisão calculada: %0.2f %%\n", accuracy);
            % textTotal
            str_f = sprintf('%0.2f %%', accuracy);
            set(handles.textTotal, 'String', str_f);
            % uitable1
            numImageTypes = size(imageTarget, 1);
            numFiles = size(imageTarget, 2);
            output = zeros(numImageTypes, numFiles);
            for i = 1 : numFiles
                [~, b] = max(y(:, i));
                output(b, i) = 1;
            end
            set(handles.uitable1,'Data',num2cell(output.'));
            fprintf("Rede testada!\n");
        else
            errordlg('Rede neuronal não existe!', 'Erro!', 'modal');
        end
end

% --- Executes on button press in checkInverted.
function checkInverted_Callback(hObject, eventdata, handles)
% hObject    handle to checkInverted (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkInverted


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Criar rede neuronal
iteracoes = str2num(get(handles.editIter, 'String'));
if (~isscalar(iteracoes))
    iteracoes = 1000;
end

layers = get(handles.editCamadas, 'String');
layers = str2num(layers);

allItems = get(handles.popHidden,'String');
selectedIndex = get(handles.popHidden,'Value');
transferFcnHidden = allItems{selectedIndex};

allItems = get(handles.popOutput,'String');
selectedIndex = get(handles.popOutput,'Value');
transferFcn = allItems{selectedIndex};

allItems = get(handles.popTreino,'String');
selectedIndex = get(handles.popTreino,'Value');
trainFcn = allItems{selectedIndex};

allItems = get(handles.popDiv,'String');
selectedIndex = get(handles.popDiv,'Value');
divideFcn = allItems{selectedIndex};

divParamTreino = str2num(get(handles.editTreino, 'String'));
if (~(isscalar(divParamTreino) && isreal(divParamTreino)))
    divParamTreino = 0.7;
end
divParamVal = str2num(get(handles.editVal, 'String'));
if (~(isscalar(divParamVal) && isreal(divParamVal)))
    divParamVal = 0.15;
end
divParamTeste = str2num(get(handles.editTeste, 'String'));
if (~(isscalar(divParamTeste) && isreal(divParamTeste)))
    divParamTeste = 0.15;
end

handles.net = feedforwardnet(layers);

% Função de ativação
for i = 1 : size(layers, 2)
    handles.net.layers{i}.transferFcn = transferFcnHidden;
end
act = size(layers, 2) + 1;
handles.net.layers{act}.transferFcn = transferFcn;

% Função de treino
handles.net.trainFcn = trainFcn;

% Número de épocas
handles.net.trainParam.epochs = iteracoes;

% Divisão de exemplos
handles.net.divideFcn = divideFcn;
if (~isempty(divideFcn))
    handles.net.divideParam.trainRatio = divParamTreino;
    handles.net.divideParam.valRatio = divParamVal;
    handles.net.divideParam.testRatio = divParamTeste;
end

str = string(strjoin(["" layers transferFcnHidden transferFcn trainFcn divideFcn divParamTreino divParamVal divParamTeste]));
set(handles.textRede, 'String', str);
set(handles.textTotal, 'String', "");
set(handles.uitable1, 'Data', cell(size(get(handles.uitable1,'Data'))));

guidata(hObject, handles);
