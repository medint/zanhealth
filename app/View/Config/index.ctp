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
<?$this->Html->script('/jtable/jquery.jtable.min.js', array('inline' => false));$this->Html->css('/jtable/themes/lightcolor/gray/jtable.min.css', NULL, array('inline' => false));?><script type="text/javascript">  $(document).ready(function() {    $('#configlist').jtable({      title: 'Manage <?= $key ?>',      actions: {        listAction: '/config/<?= $model ?>/find',        <? if (!isset($isUserConfig) || !$isUserConfig){ ?>
        createAction: '/config/<?= $model ?>/create',        updateAction: '/config/<?= $model ?>/update',        <? } ?>
        deleteAction: '/config/<?= $model ?>/delete'      },      fields: <?= json_encode($fields) ?>    }).jtable('load');  });</script><div id="configlist"></div>

<? if (isset($isUserConfig) && $isUserConfig){ ?>
  <div style="float: right;"><?= $this->Html->image('new_user.png', array('url' => array('controller' => 'users', 'action' => 'add'))) ?></div>
<? } ?>