<?
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
?>
<!--
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
-->
<!DOCTYPE html>
<html>
  <head>
    <?php echo $this->Html->charset(); ?>
    <title>
      ZanHealth: <?php echo $title_for_layout; ?>
    </title>
    <?php echo $this->Html->meta('icon'); ?>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?
      echo $this->Html->css('default.css');
      echo $this->Html->script('ie_reduce');
      echo $this->Html->script('//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js');
      echo $this->Html->script('jquery-ui-1.9.2.custom.min.js');
      echo $this->Html->script('bootstrap.min');
      echo $this->Html->script('jquery.doubleScroll');
      echo $this->Html->script('jquery.datetimepicker');
      echo $this->Html->script('handlebars');

      echo $this->fetch('meta');
      echo $this->fetch('css');
      echo $this->fetch('script');
    ?>
  </head>
  <body>
    <div style="min-height: 100%; position: relative; padding-bottom: 30px;">
      <? if ($m = $this->Session->flash()){ ?>
        <div id="flash" class="alert">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <?php echo $m; ?>
        </div>
      <? } ?>
      <div id="container" class="span10 offset1">
        <? if (!isset($layout_header) || $layout_header !== false){ ?>
          <div class="row">
            <div id="header" class="span10">
              <?= $this->Html->image('banner.jpg', array('class' => 'banner')) ?>
              <?= $this->element('navbar'); ?>
            </div>
          </div>
        <? } ?>
        <div class="row">
          <div id="content" class="span10">
            <?php echo $this->fetch('content'); ?>
          </div>
        </div>
        <div class="row">
          <div id="footer" class="span10">
          </div>
        </div>
      </div>
      <div id="footer">
        Open Source LAGPL v3 Licensed,
        <a target="_blank" href="http://rcchan.com">Copyright &copy; 2013 Ryan Chan</a>
      </div>
    </div>
  </body>
</html>