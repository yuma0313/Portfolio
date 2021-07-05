<script type="text/javascript">

    function initMap() {
        var test = {lat: <%= @post_image.latitude %>, lng: <%= @post_image.longitude %>};
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15,
            center: test
        });
        var transitLayer = new google.maps.TransitLayer();
        transitLayer.setMap(map);

        var contentString = '住所：<%#= @post_image.prefecture %><%#= @post_image.address %>';
        var infowindow = new google.maps.InfoWindow({
            content: contentString
        });

        var marker = new google.maps.Marker({
            position:test,
            map: map,
            title: contentString
        });

        marker.addListener('click', function() {
            infowindow.open(map, marker);
        });
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=<%= ENV['GOOGLE_MAP_API_KEY'] %>&callback=initMap"></script>