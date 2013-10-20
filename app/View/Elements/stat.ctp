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
<?
$this->Html->script('highcharts', array('inline' => false));
$this->Html->script('highcharts_exporting', array('inline' => false));
$this->Html->script('highcharts.theme.grid', array('inline' => false));
$this->Html->script('stat', array('inline' => false));
?>
<form method="POST">
  <select name="statdomain">
    <option value="">All</option>
    <? foreach($domains as $d){ ?>
      <option value="<?= $d ?>"<?= $d == $domain ? ' selected="selected"' : '' ?>><?= $d ?></option>
    <? } ?>
  </select>
</form>
<div class="stats">
  <div class="status"></div>
  <div class="utilization"></div>
</div>

<script type="text/javascript">
zanhealth.pie('Asset Inventory Status', <?= json_encode($stats['status']) ?>, $('.stats .status'));
zanhealth.pie('Asset Utilization', <?= json_encode($stats['utilization']) ?>, $('.stats .utilization'));
$('select[name=statdomain]').change(function(e){arguments;
  $(this).parent().submit();
});
</script>