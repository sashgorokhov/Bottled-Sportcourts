<meta property="og:title" content="Спортивные площадки в Екатеринбурге" />
<meta property="og:site_name" content="SportCourts.ru" />
<meta property="og:type" content="website" />
<meta property="og:url" content="http://{{serverinfo['ip']}}:{{serverinfo['port']}}"/courts?all}}>
<meta property="og:image" content="http://cdn2.img22.ria.ru/images/39169/16/391691688.jpg" />
<meta property="og:description" content="Актуальная база спортивных площадок нашего города. Здесь мы играем."/>

<script src="http://api-maps.yandex.ru/1.1/index.xml?key=ADtA-FMBAAAAO_95dwIAb8cxoJ0XVsmlrrEljkqDE8QIFgsAAAAAAAAAAADwojBjdahSnZySk0zChxiVovWqNw==" type="text/javascript"></script>

<style>
a.title.active{
	text-decoration: underline;
    font-size: 110%;
    font-weight: bold;
}
</style>

<script type="text/javascript">

    // Создание обработчика для события window.onLoad
    YMaps.jQuery(function () {
        // Создание экземпляра карты и его привязка к созданному контейнеру
        var map = new YMaps.Map(YMaps.jQuery("#YMapsID")[0]);

        // Установка для карты ее центра и масштаба
        map.setCenter(new YMaps.GeoPoint({{city['geopoint']}}), 12);

        // Добавление элементов управления
        map.enableScrollZoom();
        map.addControl(new YMaps.ToolBar());
        map.addControl(new YMaps.TypeControl());
        map.addControl(new YMaps.Zoom());

        // Группы объектов
        var groups = [
            {{!','.join(groups)}}
        ];

        // Создание списка групп
        for (var i = 0; i < groups.length; i++) {
            addMenuItem(groups[i], map, YMaps.jQuery("#menu"));
        }

        map.addOverlay(groups[0]);

    })

    // Добавление одного пункта в список
    function addMenuItem (group, map, menuContainer) {

        // Показать/скрыть группу на карте
        YMaps.jQuery("<a class=\"title\" href=\"#\">" + group.title + "</a>")
            .bind("click", function () {
                var link = YMaps.jQuery(this);

                // Если пункт меню "неактивный", то добавляем группу на карту,
                // иначе - удаляем с карты
                if (link.hasClass("active")) {
                    map.removeOverlay(group);
                } else {
                    $('.active').removeClass("active");
                    map.removeAllOverlays();
                    map.addOverlay(group);
                }

                // Меняем "активность" пункта меню
                link.toggleClass("active");

                return false;
            })

            // Добавление нового пункта меню в список
            .appendTo(
                YMaps.jQuery("<li></li>").appendTo(menuContainer)
            )
    };

    // Создание группы
    function createGroup (title, objects, style) {
        var group = new YMaps.GeoObjectCollection(style);

        group.title = title;
        group.add(objects);
        
        return group;
    };

    // Создание метки
    function createPlacemark (point, name, description) {
        var placemark = new YMaps.Placemark(point);

        placemark.name = name;
        placemark.description = description;

        return placemark
    }

    window.onload = function() {
        $('#menu').find(':first-child').find(':first-child').addClass('active');
    }
    
</script>