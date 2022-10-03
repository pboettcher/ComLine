program Comline;

uses Windows;

{$R *.RES}

const BW=55; //ButtonWidth

var Form:TWndClass;
    HWn,HForm,Button1,Memo1:HWnd;
    Font:hFont;
    Msg:TMsg;
    Rect:TRect;

procedure Terminate;
begin
  UnRegisterClass('Window',HWn);
  ExitProcess(HWn);
end;

function WindowProc(hWnd,Msg,wParam,lParam:Longint):Longint; stdcall;
begin
  Result:=DefWindowProc(hWnd,Msg,wParam,lParam);
  case Msg of
    273: if Lparam=Button1 then Terminate; //WM_COMMAND
      2: Terminate; //WM_DESTROY
    256: begin //WM_KEYDOWN
           if wParam=27 then Terminate;
         end;
  end;
end;

begin
  HWn:=GetModuleHandle(NIL);
  with Form do begin
    Style:=CS_PARENTDC;
    lpfnWndProc:=@WindowProc;
    hInstance:=HWn;
    hbrBackground:=COLOR_BTNFACE+1;
    lpszClassName:='Window';
    hCursor:=LoadCursor(0,IDC_ARROW);
  end;
  RegisterClass(Form);
  {Form}
  GetClientRect(GetDesktopWindow,Rect);
  HForm:=CreateWindowW('Window','Command line',
  281673728,0,Rect.Bottom div 2,Rect.Right,48,0,0,hwn,NIL);
  {Memo}
  GetClientRect(HForm,Rect);
  Memo1:=CreateWindowExW(512,'Edit','',1342181376 or ES_AUTOHSCROLL or
  ES_READONLY,
  0,0,Rect.Right-BW,Rect.Bottom,HForm,0,HWn,NIL);
  Font:=CreateFont(14,0,0,0,fw_DontCare,0,0,0,
  1,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,PROOF_QUALITY,VARIABLE_PITCH,
  'MS Sans Serif');
  SendMessage(Memo1,48,Font,0);
  SetWindowText(Memo1,GetCommandLine);
  SetFocus(Memo1);
  {Button}
  Button1:=CreateWindow('Button','Close',
  WS_VISIBLE or WS_CHILD or BS_PUSHLIKE or BS_TEXT,
  Rect.Right-BW,0,BW,Rect.Bottom,HForm,0,HWn,NIL);
  SendMessage(Button1,48,Font,0);
  {Messages}
  while(GetMessage(Msg,HForm,0,0))do begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end.

