function blocked = checkRouteRequestBlocked(src,t)
    if t-src.last_route_request_time < src.route_discovery_delay
        blocked = true;
    else
        blocked = false;
    end
end