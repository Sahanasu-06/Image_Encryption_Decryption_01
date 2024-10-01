function varargout = recovermsg(varargin)
% RECOVERMSG MATLAB code for recovermsg.fig
%      RECOVERMSG, by itself, creates a new RECOVERMSG or raises the existing
%      singleton*.
%
%      H = RECOVERMSG returns the handle to a new RECOVERMSG or the handle to
%      the existing singleton*.
%
%      RECOVERMSG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOVERMSG.M with the given input arguments.
%
%      RECOVERMSG('Property','Value',...) creates a new RECOVERMSG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before recovermsg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to recovermsg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help recovermsg

% Last Modified by GUIDE v2.5 10-Jul-2024 20:34:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @recovermsg_OpeningFcn, ...
                   'gui_OutputFcn',  @recovermsg_OutputFcn, ...
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


% --- Executes just before recovermsg is made visible.
function recovermsg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recovermsg (see VARARGIN)

% Choose default command line output for recovermsg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes recovermsg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = recovermsg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fn,fp]=uigetfile('Select Image to Encrypt');
fpath=strcat(fp,fn);
set(handles.edit1,'String',fpath);
img=imread(fpath)
axes(handles.axes1)
imshow(img)
title('Original Image')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fname=get(handles.edit1,'String');
A=imread(fname);
K=10001;
lambda=2;
IK=mod(sum(sum(sum(A))),K);
MK=IK/K;
handles.MK=MK;
handles.IK=IK;
S=zeros(size(A,1),size(A,2),3);
for i=1:2
    su(i)=sum(sum(A(:,:,i)));
end

 for k=1:2
        n=mod(su(k),6)+1;
        switch n
            case 1
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(1,i)= xl(IK+i-1);
                end
            case 2
                xc=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xc(i+1)=cos(5*acos(xc(i)));
                end
                for i=1:size(A,k)
                    x(2,i)= xc(IK+i-1);
                end
            case 3
                xg=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xg(i+1)=exp(-4.9*xg(i)*xg(i))+(-0.58);
                end
                for i=1:size(A,k)
                    x(3,i)= xg(IK+i-1);
                end
            case 4
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(4,i)= xl(IK+i-1);
                end
            case 5
                xb=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xb(i+1)=mod(2*xb(i),1);
                    if xb(i+1)==0
                        xb(i+1)=0.1*MK;
                    end
                end
                for i=1:size(A,k)
                    x(5,i)= xb(IK+i-1);
                end
            case 6
                xs=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xs(i+1)=0.9*sin(pi*xs(i));
                end
                for i=1:size(A,k)
                    x(6,i)= xs(IK+i-1);
                end
        end
                switch k
                    case 1
                        for i=1:size(A,1)
                            S(i,1,1)=x(n,i);
                        end
                    case 2
                        for i=1:size(A,1)
                            S(1,i+1,1)=x(n,i).';
                        end
                end
 end
 
 for k=1:2
        n=mod(sum(str2num(num2str(su(k)).')),6)+1;
        switch n
            case 1
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(1,i)= xl(IK+i-1);
                end
            case 2
                xc=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xc(i+1)=cos(5*acos(xc(i)));
                end
                for i=1:size(A,k)
                    x(2,i)= xc(IK+i-1);
                end
            case 3
                xg=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xg(i+1)=exp(-4.9*xg(i)*xg(i))+(-0.58);
                end
                for i=1:size(A,k)
                    x(3,i)= xg(IK+i-1);
                end
            case 4
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(4,i)= xl(IK+i-1);
                end
            case 5
                xb=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xb(i+1)=mod(2*xb(i),1);
                    if xb(i+1)==0
                        xb(i+1)=0.1*MK;
                    end
                end
                for i=1:size(A,k)
                    x(5,i)= xb(IK+i-1);
                end
            case 6
                xs=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xs(i+1)=0.9*sin(pi*xs(i));
                end
                for i=1:size(A,k)
                    x(6,i)= xs(IK+i-1);
                end
        end 
                switch k
                    case 1
                        for i=1:size(A,1)
                            S(i,1,2)=x(n,i);
                        end
                    case 2
                        for i=1:size(A,2)
                            S(1,i+1,2)=x(n,i).';
                        end
                end
 end
 
 for k=1:2
        n=mod(sum(de2bi(su(k))),6)+1;
        switch n
            case 1
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(1,i)= xl(IK+i-1);
                end
            case 2
                xc=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xc(i+1)=cos(5*acos(xc(i)));
                end
                for i=1:size(A,k)
                    x(2,i)= xc(IK+i-1);
                end
            case 3
                xg=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xg(i+1)=exp(-4.9*xg(i)*xg(i))+(-0.58);
                end
                for i=1:size(A,k)
                    x(3,i)= xg(IK+i-1);
                end
            case 4
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(4,i)= xl(IK+i-1);
                end
            case 5
                xb=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xb(i+1)=mod(2*xb(i),1);
                    if xb(i+1)==0
                        xb(i+1)=0.1*MK;
                    end
                end
                for i=1:size(A,k)
                    x(5,i)= xb(IK+i-1);
                end
            case 6
                xs=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xs(i+1)=0.9*sin(pi*xs(i));
                end
                for i=1:size(A,k)
                    x(6,i)= xs(IK+i-1);
                end
        end
                switch k
                    case 1
                        for i=1:size(A,1)
                            S(i,1,3)=x(n,i);
                        end
                    case 2
                        for i=1:size(A,2)
                           S(1,i+1,3)=x(n,i).';
                        end
                end
 end

for k=1:3
    for j=1:(size(A,1)-1)
        for i=2:(size(A,2)+1)
            S(j+1,i,k)= ((1-0.2)*(1-(lambda*S(j,i,k)*S(j,i,k))))+ (0.2*(1-(lambda*S(j,i-1,k)*S(j,i-1,k))));
        end
    end
    S1(:,:,k)=S(:,2:(size(A,2)+1),k);
end
S1=mod(round(S1*(10^14)),256);

xh=0.1*MK; yh=0.1*MK;
for i=1:(max(size(A,1),size(A,2))+IK)
	xh(i+1)=yh(i)+1-(1.4*xh(i)*xh(i));
	yh(i+1)=0.3*xh(i);
end
for i=1:size(A,1)
	xh1(i)= xh(IK+i-1);
end
 for i=1:size(A,2)
	yh1(i)= yh(IK+i-1);
end
[temp,index1]=sort(abs(xh1));
[temp,index2]=sort(abs(yh1));
for k=1:3
    for i=1:size(A,1)
        for j=1:size(A,2)
            A1(i,j,k)=A(index1(i),index2(j),k);
        end
    end
end
handles.su=su
encrypt=bitxor(A1,uint8(S1));
imwrite(encrypt,'encrypt1.tiff');
img=imread('encrypt1.tiff')
axes(handles.axes2)
imshow(img)
title('Encrypted Image')
 guidata(hObject,handles)


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fn,fp]=uigetfile('Select Image to Encrypt');
fpath=strcat(fp,fn);
set(handles.edit2,'String',fpath);
img=imread(fpath)
axes(handles.axes3)
imshow(img)
title('Encrypted  Image')



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fname=get(handles.edit2,'String');
A=imread(fname);
MK=handles.MK
IK=handles.IK
su=handles.su
K=10001;
lambda=2;
% IK=2815;
MK=IK/K;
% su=[47244551,25965682];

for k=1:2
        n=mod(su(k),6)+1;
        switch n
            case 1
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(1,i)= xl(IK+i-1);
                end
            case 2
                xc=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xc(i+1)=cos(5*acos(xc(i)));
                end
                for i=1:size(A,k)
                    x(2,i)= xc(IK+i-1);
                end
            case 3
                xg=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xg(i+1)=exp(-4.9*xg(i)*xg(i))+(-0.58);
                end
                for i=1:size(A,k)
                    x(3,i)= xg(IK+i-1);
                end
            case 4
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(4,i)= xl(IK+i-1);
                end
            case 5
                xb=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xb(i+1)=mod(2*xb(i),1);
                    if xb(i+1)==0
                        xb(i+1)=0.1*MK;
                    end
                end
                for i=1:size(A,k)
                    x(5,i)= xb(IK+i-1);
                end
            case 6
                xs=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xs(i+1)=0.9*sin(pi*xs(i));
                end
                for i=1:size(A,k)
                    x(6,i)= xs(IK+i-1);
                end
        end
                switch k
                    case 1
                        for i=1:size(A,1)
                            S(i,1,1)=x(n,i);
                        end
                    case 2
                        for i=1:size(A,1)
                            S(1,i+1,1)=x(n,i).';
                        end
                end
 end
 
 for k=1:2
        n=mod(sum(str2num(num2str(su(k)).')),6)+1;
        switch n
            case 1
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(1,i)= xl(IK+i-1);
                end
            case 2
                xc=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xc(i+1)=cos(5*acos(xc(i)));
                end
                for i=1:size(A,k)
                    x(2,i)= xc(IK+i-1);
                end
            case 3
                xg=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xg(i+1)=exp(-4.9*xg(i)*xg(i))+(-0.58);
                end
                for i=1:size(A,k)
                    x(3,i)= xg(IK+i-1);
                end
            case 4
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(4,i)= xl(IK+i-1);
                end
            case 5
                xb=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xb(i+1)=mod(2*xb(i),1);
                    if xb(i+1)==0
                        xb(i+1)=0.1*MK;
                    end
                end
                for i=1:size(A,k)
                    x(5,i)= xb(IK+i-1);
                end
            case 6
                xs=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xs(i+1)=0.9*sin(pi*xs(i));
                end
                for i=1:size(A,k)
                    x(6,i)= xs(IK+i-1);
                end
        end 
                switch k
                    case 1
                        for i=1:size(A,1)
                            S(i,1,2)=x(n,i);
                        end
                    case 2
                        for i=1:size(A,2)
                            S(1,i+1,2)=x(n,i).';
                        end
                end
 end
 
 for k=1:2
        n=mod(sum(de2bi(su(k))),6)+1;
        switch n
            case 1
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(1,i)= xl(IK+i-1);
                end
            case 2
                xc=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xc(i+1)=cos(5*acos(xc(i)));
                end
                for i=1:size(A,k)
                    x(2,i)= xc(IK+i-1);
                end
            case 3
                xg=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xg(i+1)=exp(-4.9*xg(i)*xg(i))+(-0.58);
                end
                for i=1:size(A,k)
                    x(3,i)= xg(IK+i-1);
                end
            case 4
                xl=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xl(i+1)=4*xl(i)*(1-xl(i));
                end
                for i=1:size(A,k)
                    x(4,i)= xl(IK+i-1);
                end
            case 5
                xb=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xb(i+1)=mod(2*xb(i),1);
                    if xb(i+1)==0
                        xb(i+1)=0.1*MK;
                    end
                end
                for i=1:size(A,k)
                    x(5,i)= xb(IK+i-1);
                end
            case 6
                xs=0.1*MK;
                for i=1:(IK+size(A,k)-1)
                    xs(i+1)=0.9*sin(pi*xs(i));
                end
                for i=1:size(A,k)
                    x(6,i)= xs(IK+i-1);
                end
        end
                switch k
                    case 1
                        for i=1:size(A,1)
                            S(i,1,3)=x(n,i);
                        end
                    case 2
                        for i=1:size(A,2)
                           S(1,i+1,3)=x(n,i).';
                        end
                end
 end
 
 for k=1:3
    for j=1:(size(A,1)-1)
        for i=2:(size(A,2)+1)
            S(j+1,i,k)= ((1-0.2)*(1-(lambda*S(j,i,k)*S(j,i,k))))+ (0.2*(1-(lambda*S(j,i-1,k)*S(j,i-1,k))));
        end
    end
    S1(:,:,k)=S(:,2:(size(A,2)+1),k);
 end

 S1=mod(round(S1*(10^14)),256);
 
 xh=0.1*MK; yh=0.1*MK;
for i=1:(max(size(A,1),size(A,2))+IK)
	xh(i+1)=yh(i)+1-(1.4*xh(i)*xh(i));
	yh(i+1)=0.3*xh(i);
end
for i=1:size(A,1)
	xh1(i)= xh(IK+i-1);
end
 for i=1:size(A,2)
	yh1(i)= yh(IK+i-1);
end
[temp,index1]=sort(abs(xh1));
[temp,index2]=sort(abs(yh1));

 A1=bitxor(A,uint8(S1));
 
for k=1:3
    for i=1:size(A,1)
        for j=1:size(A,2)
            decrypt1(index1(i),index2(j),k)=A1(i,j,k);
        end
    end
end
disp('decryption')
imwrite(decrypt1,'recovered_image.jpg')
img=imread('recovered_image.jpg')
axes(handles.axes4)
imshow(img)
title('Retrieved Image')
fname=get(handles.edit1,'String');
img1=imread(fname)
[peaksnr, snr] = psnr(A, img);
set(handles.edit4,'String',peaksnr);
set(handles.edit5,'String',snr);

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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
