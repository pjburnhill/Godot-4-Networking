extends Node

var upnp = UPNP.new()

const searchTime = 2000
const timeToLive = 2
const filter = "InternetGatewayDevice"
var discover_result
var map_result_udp
var map_result_tcp
var external_ip
var both_ports_mapped

func set_upnp_mapping(port, description):
	print('Setting up uPNP port forwarding, using port ', port)
	discover_result = upnp.discover(searchTime, timeToLive, filter)

	if discover_result == UPNP.UPNP_RESULT_SUCCESS:
		print('uPNP Discovery successful.')
		if upnp.get_gateway() and upnp.get_gateway().is_valid_gateway():
			print('Valid uPNP gateway found.')
			
			map_result_udp = upnp.add_port_mapping(port,0, description, 'UDP', 0)
			map_result_tcp = upnp.add_port_mapping(port,0, description, 'TCP', 0)
			
			if not map_result_udp == UPNP.UPNP_RESULT_SUCCESS:
				map_result_udp = upnp.add_port_mapping(port,0, '', 'UDP', 0)
			if not map_result_tcp == UPNP.UPNP_RESULT_SUCCESS:
				map_result_tcp = upnp.add_port_mapping(port,0, '', 'TCP', 0)
			
			if map_result_udp == UPNP.UPNP_RESULT_SUCCESS && map_result_tcp == UPNP.UPNP_RESULT_SUCCESS:
				both_ports_mapped = true
				external_ip = upnp.query_external_address()
	
	return self

func delete_upnp_mapping(port, protocol):
	upnp.delete_port_mapping(port, protocol)
	return self
