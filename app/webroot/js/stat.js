/**************************************************************************\
* Copyright 2013 Ryan Chan <ryan@rcchan.com>                               *
*                                                                          *
* This program is free software: you can redistribute it and/or modify     *
* it under the terms of the GNU Affero General Public License as           *
* published by the Free Software Foundation, either version 3 of the       *
* License, or (at your option) any later version.                          *
*                                                                          *
* This program is distributed in the hope that it will be useful,          *
* but WITHOUT ANY WARRANTY; without even the implied warranty of           *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
* GNU Affero General Public License for more details.                      *
*                                                                          *
* You should have received a copy of the GNU Affero General Public License *
* along with this program.  If not, see <http://www.gnu.org/licenses/>.    *
*                                                                          *
*                                                                          *
* Additional permission under the GNU Affero GPL version 3 section 7:      *
*                                                                          *
* If you modify this Program, or any covered work, by linking or           *
* combining it with other code, such other code is not for that reason     *
* alone subject to any of the requirements of the GNU Affero GPL           *
* version 3.                                                               *
\**************************************************************************/
var zanhealth=zanhealth||{};zanhealth.pie=function(t,e,n){var o;$(document).ready(function(){// Apply the theme
Highcharts.setOptions(Highcharts.theme),// Radialize the colors
Highcharts.getOptions().colors=Highcharts.map(Highcharts.getOptions().colors,function(t){return{radialGradient:{cx:.5,cy:.3,r:.7},stops:[[0,t],[1,Highcharts.Color(t).brighten(-.3).get("rgb")]]}}),// Build the chart
$(n).each(function(n,r){o=new Highcharts.Chart({chart:{renderTo:r,plotBackgroundColor:null,plotBorderWidth:null,plotShadow:!0},title:{text:t},tooltip:{pointFormat:"{series.name}: <b>{point.percentage}%</b>",percentageDecimals:1},plotOptions:{pie:{allowPointSelect:!0,cursor:"pointer",dataLabels:{enabled:!0,color:"#000000",connectorColor:"#000000",overflow:"justify",distance:10,softConnector:!1,formatter:function(){return this.point.name}},showInLegend:!0}},legend:{labelFormatter:function(){return"<b>"+this.name+":</b> "+Math.round(1e3*(this.y/this.series.yData.reduce(function(t,e){return t+e})))/10+"%"},layout:"vertical"},series:[{type:"pie",name:t,data:e}],exporting:{buttons:{printButton:{enabled:!1}}}})})})};