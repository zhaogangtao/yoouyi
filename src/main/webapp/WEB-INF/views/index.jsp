<%@ page language="java" pageEncoding="UTF-8"
         contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en" data-ng-app="travelWeb" data-ng-controller="TravelWebController">
<head>
    <base href="http://${header.host}${pageContext.request.contextPath}/" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>游易网 </title>
    <meta name="keywords" content="游易网,{{travelWeb.starting}},{{travelWeb.starting}}旅游,{{travelWeb.starting}}旅游线路" />
    <meta name="description" content="游易网让旅游变得更容易,{{travelWeb.starting}}旅游大全,{{travelWeb.starting}}旅游线路大全,{{travelWeb.starting}}旅游线路优惠信息" />

    <link href="resources/css/bootstrap.min.css" rel="stylesheet">

    <script type="text/javascript" src="http://cbjs.baidu.com/js/m.js"></script>

    <script src="http://api.map.baidu.com/api?v=2.0&ak=T0vh70ZX0xIy8YfDQaBdzCAK"></script>
    <script src="resources/js/underscore-1.7.0/underscore-min.js"></script>

    <script src="resources/js/angular-1.2.25/angular.min.js"></script>
    <script src="resources/js/angular-1.2.25/angular-route.min.js"></script>
    <script src="resources/js/ui-bootstrap-0.11.2/ui-bootstrap-tpls-0.11.2.min.js"></script>

    <script src="resources/js/sys-web/app.js"></script>
    <script src="resources/js/sys-web/TravelWebController.js"></script>
    <script src="resources/js/sys-web/UserModalController.js"></script>
    <script src="resources/js/sys-web/CommonDirective.js"></script>

    <script src="resources/js/sys-web/search/search.js"></script>
    <script src="resources/js/sys-web/search/SearchController.js"></script>

    <script src="resources/js/sys-web/member/member.js"></script>
    <script src="resources/js/sys-web/member/FavoriteController.js"></script>
    


    <script src="resources/js/jquery-1.11.1.min.js"></script>

    <!--script src="resources/js/sys-web/search.js"></script-->

    <link rel="stylesheet/less" type="text/css" href="resources/css/lvyou.less" />
    <script src="resources/js/less-v2.0.0-b1/less.min.js"></script>

</head>

<body>

<header>

    <div class="container">

        <div class="top-ad">
            <script type="text/javascript">BAIDU_CLB_fillSlot("1013169");</script>
        </div>

        <div class="header">
            <div class="ly-logo-container">
                <div class="logo"></div>
                <div class="slogan"></div>

                <div class="ly-city dropdown">
                        <span class="label label-default dropdown-toggle" data-toggle="dropdown">
                            {{travelWeb.starting}}
                            <i class="caret"></i>
                        </span>
                    <div class="dropdown-menu ly-cities" role="menu" aria-labelledby="dropdownMenu1">
                        <span class="label {{ travelWeb.selectedCity.id == city.id ? 'label-primary' : 'label-default' }}" 
                        data-ng-click="changeCity(city)" data-ng-if="city.show" data-ng-repeat="city in constants.cities">{{ city.city }}</span>
                    </div>
                    <div id="amap-container"></div>
                </div>
            </div>
            <div class="ly-search-container">
                <div class="col-xs-10">

                    <div class="col-xs-8">
                        <div class="input-group">
                            <input type="text" id="travelDestination" data-ng-model="travelWeb.destination"
                                   data-ng-keydown="onSearchEvent($event)" name="destination" class="form-control">
                            <span class="input-group-btn">
                            <button type="button" data-ng-click="searchTravel()" id="travelSearchBtn" class="btn btn-primary">搜索线路</button>
                          </span>
                        </div>
                    </div>
                
                </div>

                <div class="col-xs-2 text-right">
                    <div data-ng-if="!travelWeb.userInfo.success">
                        <a data-ng-click="signUp()">注册</a>
                        <a data-ng-click="signIn()">登录</a>
                    </div>
                    <div dropdown  data-ng-if="travelWeb.userInfo.success">
                        <a dropdown-toggle>
                            <span class="ly-username">{{ travelWeb.userInfo.data.username }}</span>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="member/favorites">我的收藏</a></li>
                            <li class="divider"></li>
                            <li><a data-ng-click="logout()">退出</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </div>

</header>

<div class="container">

    <div class="row main">
        <div class="col-xs-2 ly-left">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">热门目的地</h3>
                </div>
                <div class="panel-body ly_hot_panel">
                    <span class="ly_hot" data-ng-if="hot != travelWeb.starting" data-ng-repeat="hot in constants.hotDestination">
                        <a data-ng-href="index/{{ travelWeb.starting }}_{{ hot }}___">
                            {{ hot }}
                        </a>
                    </span>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">热门国外目的地</h3>
                </div>
                <div class="panel-body ly_hot_panel">
                    <span class="ly_hot" data-ng-if="hot != travelWeb.starting" data-ng-repeat="hot in constants.hotOutDestination">
                        <a data-ng-href="index/{{ travelWeb.starting }}_{{ hot }}___">
                            {{ hot }}
                        </a>
                    </span>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">旅游线路推荐</h3>
                </div>
                <div class="panel-body ly-tuijian">
                    <a href="#" class="thumbnail">
                        <img src="resources/images/list2.jpg" alt="...">
                    </a>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">最近浏览</h3>
                </div>
                <div class="panel-body ly-jingdian">
                    <ul class="ly_recent_ul">
                    	<li class="ly_recent_line" data-ng-repeat="recent in travelWeb.recentList">{{ recent.trip.title }}</li>
                    </ul>
                </div>
            </div>

        </div>
        <div class="col-xs-10 ly-right" data-ng-view>

        </div>
    </div>

</div>

<footer class="footer">
    <p class="text-center">Copyright &copy; 2014 游易 版权所有</p>
</footer>

<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?d37b0cb4199dd4829323d743514708f7";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</body>
</html>

