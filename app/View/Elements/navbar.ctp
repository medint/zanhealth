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
<div class="navbar nav">
  <div class="navbar-inner">
    <ul class="nav">
      <li><a href="/">Home</a></li>
      <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
          Config System
          <b class="caret"></b>
        </a>
        <ul class="dropdown-menu">
          <?
            global $configurable;
            foreach($configurable as $c){
          ?>
            <li><?= $this->Html->link('Manage ' . Inflector::pluralize($c), '/config/' . $c) ?></li>
          <? } ?>
        </ul>
      </li>
      <li><a href="/items">Manage Item</a></li>
      <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
          Maintenance
          <b class="caret"></b>
        </a>
        <ul class="dropdown-menu">
          <li><a href="/workRequests/create">New Work Request</a></li>
          <li><a href="/workRequests">View Requests</a></li>
          <li><a href="/workRequests/status/closed">Closed Work Requests</a></li>
          <li><a href="/workRequests/reports">Reports</a></li>
        </ul>
      </li>
      <li class="dropdown">
        <?= $this->Html->link('Needs List', array('controller' => 'needs', 'action' => 'index')) ?>
      </li>
      <? if ($user){ ?>
        <li class="dropdown pull-right">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            Account Info
            <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a href="/users/changepass">Change Password</a></li>
            <li><a href="/users/logout">Log out</a></li>
          </ul>
        </li>
      <? } ?>
    </ul>
  </div>
</div>