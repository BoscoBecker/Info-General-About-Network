unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,NETWORKLIST_TLB,
  Vcl.WinXCtrls;

type
  TForm1 = class(TForm)
    mmInfoWifi: TMemo;
    btnGetInfo: TButton;
    Label1: TLabel;
    procedure btnGetInfoClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetInfo;
    procedure GetNetworks;
    function GetNetworkCategory(Category : NLM_NETWORK_CATEGORY) : string;
    function GetNetworkDomainType(DomainType : NLM_DOMAIN_TYPE) : string;
    function GetNetworkConnectivity(Connectivity : NLM_CONNECTIVITY) : string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

{ TForm1 }

procedure TForm1.btnGetInfoClick(Sender: TObject);
begin
  GetInfo;
  GetNetworks;
end;

procedure TForm1.GetInfo;
var
  NetworkListManager: INetworkListManager;
  EnumNetworkConnections: IEnumNetworkConnections;
  NetworkConnection : INetworkConnection;
  pceltFetched: ULONG;
begin
   mmInfoWifi.Lines.Clear;
   NetworkListManager := CoNetworkListManager.Create;
   EnumNetworkConnections :=  NetworkListManager.GetNetworkConnections();
   while true do
   begin
     EnumNetworkConnections.Next(1, NetworkConnection, pceltFetched);
     if (pceltFetched>0)  then
     begin
        mmInfoWifi.Lines.add('Info About Network Adpter connected');
        mmInfoWifi.Lines.add(#13);
        mmInfoWifi.Lines.add(Format('Adapter Id      : %s', [GuidToString(NetworkConnection.GetAdapterId)]));
        mmInfoWifi.Lines.add(Format('Connection Id   : %s', [GuidToString(NetworkConnection.GetConnectionId)]));
        mmInfoWifi.Lines.add(Format('Domain Type     : %s', [GetNetworkDomainType(NetworkConnection.GetDomainType)]));
        mmInfoWifi.Lines.add(Format('Connected       : %s', [boolToStr(NetworkConnection.IsConnected, True)]));
        mmInfoWifi.Lines.add(Format('Internet        : %s', [boolToStr(NetworkConnection.IsConnectedToInternet, True)]));
        mmInfoWifi.Lines.add(Format('Network         : %s', [NetworkConnection.GetNetwork.GetName]));
        mmInfoWifi.Lines.add(Format('Connectivity    : %s', [GetNetworkConnectivity(NetworkConnection.GetConnectivity)]));
     end
     else
     Break;
   end;
end;

function TForm1.GetNetworkCategory(Category: NLM_NETWORK_CATEGORY): string;
begin
 Result:='';
  case Category of
    NLM_NETWORK_CATEGORY_PUBLIC               : Result := 'Public';
    NLM_NETWORK_CATEGORY_PRIVATE              : Result := 'Private';
    NLM_NETWORK_CATEGORY_DOMAIN_AUTHENTICATED : Result := 'Authenticated';
  end;
end;

function TForm1.GetNetworkConnectivity(Connectivity: NLM_CONNECTIVITY): string;
begin
 Result:='';
    if NLM_CONNECTIVITY_DISCONNECTED and Connectivity <> 0 then  Result := Result+ 'Disconnected, ';
    if NLM_CONNECTIVITY_IPV4_NOTRAFFIC and Connectivity <> 0 then  Result := Result+ 'Connected but not ipv4 traffic, ';
    if NLM_CONNECTIVITY_IPV6_NOTRAFFIC  and Connectivity <> 0 then  Result := Result+  'Connected but not ipv6 traffic, ';
    if NLM_CONNECTIVITY_IPV4_SUBNET  and Connectivity <> 0 then  Result := Result+  'Subnet ipv4, ';
    if NLM_CONNECTIVITY_IPV4_LOCALNETWORK  and Connectivity <> 0 then  Result := Result+  'LocalNetwork ipv4, ';
    if NLM_CONNECTIVITY_IPV4_INTERNET  and Connectivity <> 0 then  Result := Result+  'Internet ipv4, ';
    if NLM_CONNECTIVITY_IPV6_SUBNET  and Connectivity <> 0 then  Result := Result+  'Subnet ipv6, ';
    if NLM_CONNECTIVITY_IPV6_LOCALNETWORK  and Connectivity <> 0 then  Result := Result+ 'LocalNetwork ipv6, ';
    if NLM_CONNECTIVITY_IPV6_INTERNET  and Connectivity <> 0 then  Result := Result+'Internet ipv6, ';

    Result:= StringReplace('['+Result+']', ', ]', ']', [rfReplaceAll]);
end;

function TForm1.GetNetworkDomainType(DomainType: NLM_DOMAIN_TYPE): string;
begin
 Result:='';
  case DomainType of
    NLM_DOMAIN_TYPE_NON_DOMAIN_NETWORK   : Result := 'Non Domain Network'; //The Network is not an Active Directory Network
    NLM_DOMAIN_TYPE_DOMAIN_NETWORK       : Result := 'Domain Network';//The Network is an Active Directory Network, but this machine is not authenticated against it.
    NLM_DOMAIN_TYPE_DOMAIN_AUTHENTICATED : Result := 'Domain Network Authenticated';//The Network is an Active Directory Network, and this machine is authenticated against it.
  end;
end;

procedure TForm1.GetNetworks;
var
  NetworkListManager: INetworkListManager;
  EnumNetworks: IEnumNetworks;

  EnumNetworksConnections: IEnumNetworkConnections;
  NetworkConnection : INetworkConnection;

  Network: INetwork;
  fetched, pceltFetched: ULONG;

  pdwLowDateTimeCreated: LongWord;
  pdwHighDateTimeCreated: LongWord;
  pdwLowDateTimeConnected: LongWord;
  pdwHighDateTimeConnected: LongWord;

  lpFileTime : TFileTime;
  lpSystemTime: TSystemTime;
  LDateTime : TDateTime;
begin
   NetworkListManager := CoNetworkListManager.Create;
   EnumNetworks :=  NetworkListManager.GetNetworks(NLM_ENUM_NETWORK_CONNECTED);
   while true do
   begin
     EnumNetworks.Next(1, Network, fetched);
     if (fetched>0)  then
     begin
       mmInfoWifi.Lines.add(#13#10);
       mmInfoWifi.Lines.add('General info about networks ');
       mmInfoWifi.Lines.add(Format('%s - %s', [Network.GetName, Network.GetDescription]));
       mmInfoWifi.Lines.add(Format('Network Id  : %s', [GuidToString(Network.GetNetworkId)]));
       mmInfoWifi.Lines.add(Format('Domain Type : %s', [GetNetworkDomainType(Network.GetDomainType)]));
       mmInfoWifi.Lines.add(Format('Category    : %s', [GetNetworkCategory(Network.GetCategory)]));

       //https://msdn.microsoft.com/en-us/library/windows/desktop/aa370787(v=vs.85).aspx
       Network.GetTimeCreatedAndConnected(pdwLowDateTimeCreated, pdwHighDateTimeCreated, pdwLowDateTimeConnected, pdwHighDateTimeConnected);

       lpFileTime.dwLowDateTime := pdwLowDateTimeCreated;
       lpFileTime.dwHighDateTime := pdwHighDateTimeCreated;
       if FileTimeToSystemTime(lpFileTime, lpSystemTime) then
       begin
          LDateTime := SystemTimeToDateTime(lpSystemTime);
          mmInfoWifi.Lines.add('Created         : '+FormatDateTime('dd/mm/yyyy hh:nn', LDateTime));
       end;

       lpFileTime.dwLowDateTime := pdwLowDateTimeConnected;
       lpFileTime.dwHighDateTime := pdwHighDateTimeConnected;
       if FileTimeToSystemTime(lpFileTime, lpSystemTime) then
       begin
          LDateTime := SystemTimeToDateTime(lpSystemTime);
          mmInfoWifi.Lines.add('Last Connection : '+FormatDateTime('dd/mm/yyyy hh:nn', LDateTime));
       end;

       mmInfoWifi.Lines.add(Format('Connected       : %s', [boolToStr(Network.IsConnected, True)]));
       mmInfoWifi.Lines.add(Format('Internet        : %s', [boolToStr(Network.IsConnectedToInternet, True)]));

       EnumNetworksConnections := Network.GetNetworkConnections();

       mmInfoWifi.Lines.add('Connections');
       while true do
       begin
         EnumNetworksConnections.Next(1, NetworkConnection, pceltFetched);
         if (pceltFetched>0)  then
         begin
           mmInfoWifi.Lines.add(Format('Adapter Id    : %s', [GuidToString(NetworkConnection.GetAdapterId)]));
           mmInfoWifi.Lines.add(Format('Connection Id : %s', [GuidToString(NetworkConnection.GetConnectionId)]));
         end
         else
         break;
       end;
     end
     else
     Break;
   end;
end;

end.
