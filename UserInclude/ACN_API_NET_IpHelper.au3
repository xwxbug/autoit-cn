#include-once
;~ IP Helper Functions

;~ The following functions retrieve and modify configuration settings for the TCP/IP transport on the local computer. The following categorical listing can help determine which collection of functions is best suited for a given task:
;~ -------------------------------------------------
;~ Adapter Management

;~ GetAdapterIndex
;~ GetAdaptersAddresses
;~ GetAdaptersInfo
;~ GetPerAdapterInfo
;~ GetUniDirectionalAdapterInfo
;~ -------------------------------------------------
;~ Address Resolution Protocol Management

;~ CreateIpNetEntry
;~ CreateProxyArpEntry
;~ DeleteIpNetEntry
;~ DeleteProxyArpEntry
;~ FlushIpNetTable
;~ GetIpNetTable
;~ SendARP
;~ SetIpNetEntry
;~ -------------------------------------------------
;~ Interface Conversion

;~ ConvertInterfaceAliasToLuid
;~ ConvertInterfaceGuidToLuid
;~ ConvertInterfaceIndexToLuid
;~ ConvertInterfaceLuidToAlias
;~ ConvertInterfaceLuidToGuid
;~ ConvertInterfaceLuidToIndex
;~ ConvertInterfaceLuidToNameA
;~ ConvertInterfaceLuidToNameW
;~ ConvertInterfaceNameToLuidA
;~ ConvertInterfaceNameToLuidW
;~ if_indextoname
;~ if_nametoindex
;~ -------------------------------------------------
;~ Interface Management

;~ GetFriendlyIfIndex
;~ GetIfEntry
;~ GetIfEntry2
;~ GetIfStackTable
;~ GetIfTable
;~ GetIfTable2
;~ GetIfTable2Ex
;~ GetInterfaceInfo
;~ GetInvertedIfStackTable
;~ GetIpInterfaceEntry
;~ GetIpInterfaceTable
;~ GetNumberOfInterfaces
;~ InitializeIpInterfaceEntry
;~ SetIfEntry
;~ SetIpInterfaceEntry
;~ -------------------------------------------------
;~ Internet Protocol and Internet Control Message Protocol

;~ GetIcmpStatistics
;~ GetIpStatistics
;~ Icmp6CreateFile
;~ Icmp6ParseReplies
;~ Icmp6SendEcho2
;~ IcmpCloseHandle
;~ IcmpCreateFile
;~ IcmpParseReplies
;~ IcmpSendEcho
;~ IcmpSendEcho2
;~ IcmpSendEcho2Ex
;~ SetIpTTL
;~ -------------------------------------------------
;~ IP Address Management

;~ AddIPAddress
;~ CreateAnycastIpAddressEntry
;~ CreateUnicastIpAddressEntry
;~ DeleteIPAddress
;~ DeleteAnycastIpAddressEntry
;~ DeleteUnicastIpAddressEntry
;~ GetAnycastIpAddressEntry
;~ GetAnycastIpAddressTable
;~ GetIpAddrTable
;~ GetMulticastIpAddressEntry
;~ GetMulticastIpAddressTable
;~ GetUnicastIpAddressEntry
;~ GetUnicastIpAddressTable
;~ InitializeUnicastIpAddressEntry
;~ IpReleaseAddress
;~ IpRenewAddress
;~ NotifyStableUnicastIpAddressTable
;~ SetUnicastIpAddressEntry
;~ -------------------------------------------------
;~ IP Address String Conversion

;~ RtlIpv4AddressToString
;~ RtlIpv4AddressToStringEx
;~ RtlIpv4StringToAddress
;~ RtlIpv4StringToAddressEx
;~ RtlIpv6AddressToString
;~ RtlIpv6AddressToStringEx
;~ RtlIpv6StringToAddress
;~ RtlIpv6StringToAddressEx
;~ -------------------------------------------------
;~ IP Neighbor Address Management

;~ CreateIpNetEntry2
;~ DeleteIpNetEntry2
;~ FlushIpNetTable2
;~ GetIpNetEntry2
;~ GetIpNetTable2
;~ ResolveIpNetEntry2
;~ ResolveNeighbor
;~ SetIpNetEntry2
;~ -------------------------------------------------
;~ IP Path Management

;~ FlushIpPathTable
;~ GetIpPathEntry
;~ GetIpPathTable
;~ -------------------------------------------------
;~ IP Route Management

;~ CreateIpForwardEntry
;~ CreateIpForwardEntry2
;~ DeleteIpForwardEntry
;~ DeleteIpForwardEntry2
;~ EnableRouter
;~ GetBestInterface
;~ GetBestInterfaceEx
;~ GetBestRoute
;~ GetBestRoute2
;~ GetIpForwardEntry2
;~ GetIpForwardTable
;~ GetIpForwardTable2
;~ GetRTTAndHopCount
;~ InitializeIpForwardEntry
;~ SetIpForwardEntry
;~ SetIpForwardEntry2
;~ SetIpStatistics
;~ SetIpStatisticsEx
;~ UnenableRouter
;~ -------------------------------------------------
;~ IP Table Memory Management

;~ FreeMibTable
;~ -------------------------------------------------
;~ IP Utility

;~ ConvertIpv4MaskToLength
;~ ConvertLengthToIpv4Mask
;~ CreateSortedAddressPairs
;~ ParseNetworkString
;~ -------------------------------------------------
;~ Network Configuration

;~ GetNetworkParams
;~ -------------------------------------------------
;~ Notification

;~ CancelMibChangeNotify2
;~ NotifyAddrChange
;~ NotifyIpInterfaceChange
;~ NotifyRouteChange
;~ NotifyRouteChange2
;~ NotifyUnicastIpAddressChange
;~ -------------------------------------------------
;~ Security Health

;~ CancelSecurityHealthChangeNotify
;~ NotifySecurityHealthChange

;~ These functions are defined only on Windows Server 2003. 

;~ Note  These functions are not available Windows Vista and Windows Server 2008. 
;~ -------------------------------------------------
;~ Teredo IPv6 Client Management

;~ GetTeredoPort
;~ NotifyTeredoPortChange
;~ NotifyStableUnicastIpAddressTable
;~ -------------------------------------------------
;~ Transmission Control Protocol and User Datagram Protocol

;~ GetExtendedTcpTable
;~ GetExtendedUdpTable
;~ GetOwnerModuleFromTcp6Entry
;~ GetOwnerModuleFromTcpEntry
;~ GetOwnerModuleFromUdp6Entry
;~ GetOwnerModuleFromUdpEntry
;~ GetPerTcp6ConnectionEStats
;~ GetPerTcpConnectionEStats
;~ GetTcpStatistics
;~ GetTcpStatisticsEx
;~ GetTcp6Table
;~ GetTcp6Table2
;~ GetTcpTable
;~ GetTcpTable2
;~ SetPerTcp6ConnectionEStats
;~ SetPerTcpConnectionEStats
;~ SetTcpEntry
;~ GetUdp6Table
;~ GetUdpStatistics
;~ GetUdpStatisticsEx
;~ GetUdpTable
;~ ===============================================================
;~ DWORD GetAdapterIndex(
;~   __in     LPWSTR AdapterName,
;~   __inout  PULONG IfIndex
;~ );

; Start - Functions

Func _GetAdapterIndex($sz_AdapterName)
	Local $IfIndex=DllStructCreate('ulong')
	local $rt=DllCall('Iphlpapi.dll','dowrd','GetAdapterIndexW','wchar',$sz_AdapterName,'ptr',DllStructGetPtr($IfIndex))
	Return DllStructGetData($IfIndex,1)
EndFunc

;~ ULONG WINAPI GetAdaptersAddresses(
;~   __in     ULONG Family,
;~   __in     ULONG Flags,
;~   __in     PVOID Reserved,
;~   __inout  PIP_ADAPTER_ADDRESSES AdapterAddresses,
;~   __inout  PULONG SizePointer
;~ );

;~ Func _GetAdaptersAddresses($n_Family,$n_Flags)
;~ 	
;~ 	DllCall('Iphlpapi.dll','ulong','GetAdaptersAddressesW','ulong',$n_Family,'ulong',$n_Flags,'none','0',
;~ 	
;~ 	
;~ 	
;~ EndFunc


;~ typedef struct _IP_ADAPTER_ADDRESSES {
;~   union {
;~     ULONGLONG Alignment;
;~     struct {
;~       ULONG Length;
;~       DWORD IfIndex;
;~     } ;
;~   } ;
;~   struct _IP_ADAPTER_ADDRESSES *Next;
;~   PCHAR                              AdapterName;
;~   PIP_ADAPTER_UNICAST_ADDRESS        FirstUnicastAddress;
;~   PIP_ADAPTER_ANYCAST_ADDRESS        FirstAnycastAddress;
;~   PIP_ADAPTER_MULTICAST_ADDRESS      FirstMulticastAddress;
;~   PIP_ADAPTER_DNS_SERVER_ADDRESS     FirstDnsServerAddress;
;~   PWCHAR                             DnsSuffix;
;~   PWCHAR                             Description;
;~   PWCHAR                             FriendlyName;
;~   BYTE                               PhysicalAddress[MAX_ADAPTER_ADDRESS_LENGTH];
;~   DWORD                              PhysicalAddressLength;
;~   DWORD                              Flags;
;~   DWORD                              Mtu;
;~   DWORD                              IfType;
;~   IF_OPER_STATUS                     OperStatus;
;~   DWORD                              Ipv6IfIndex;
;~   DWORD                              ZoneIndices[16];
;~   PIP_ADAPTER_PREFIX                 FirstPrefix;
;~   ULONG64                            TransmitLinkSpeed;
;~   ULONG64                            ReceiveLinkSpeed;
;~   PIP_ADAPTER_WINS_SERVER_ADDRESS_LH FirstWinsServerAddress;
;~   PIP_ADAPTER_GATEWAY_ADDRESS_LH     FirstGatewayAddress;
;~   ULONG                              Ipv4Metric;
;~   ULONG                              Ipv6Metric;
;~   IF_LUID                            Luid;
;~   SOCKET_ADDRESS                     Dhcpv4Server;
;~   NET_IF_COMPARTMENT_ID              CompartmentId;
;~   NET_IF_NETWORK_GUID                NetworkGuid;
;~   NET_IF_CONNECTION_TYPE             ConnectionType;
;~   TUNNEL_TYPE                        TunnelType;
;~   SOCKET_ADDRESS                     Dhcpv6Server;
;~   BYTE                               Dhcpv6ClientDuid[MAX_DHCPV6_DUID_LENGTH];
;~   ULONG                              Dhcpv6ClientDuidLength;
;~   ULONG                              Dhcpv6Iaid;
;~   PIP_ADAPTER_DNS_SUFFIX             FirstDnsSuffix;
;~ }IP_ADAPTER_ADDRESSES, *PIP_ADAPTER_ADDRESSES;