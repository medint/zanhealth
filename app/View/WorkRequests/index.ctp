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
<? $this->Html->script('jquery.dataTables.min', array('inline' => false)) ?>
<script type="text/javascript">
  $(document).ready(function(){
    var dt = $('#requests').dataTable({
      "bJQueryUI": true,
      "sPaginationType": "full_numbers",
      "bPaginate": false,
      "oLanguage": { "sZeroRecords": "No work orders were found" }
    });
    dt.wrap('<div style="width:100%; max-height: 500px; overflow: auto; white-space: nowrap;">').parent().doubleScroll().css('overflow-y', 'auto');
    
    $('thead.data_filters input').keyup( function () {
      dt.fnFilter( this.value, $('thead.data_filters input, thead.data_filters select').index(this) );
    } );
    $('thead.data_filters select').change( function () {
      dt.fnFilter( this.value, $('thead.data_filters input, thead.data_filters select').index(this) );
    } );    
  });
</script>
<div style="position: relative">
  <?=
    $this->Html->link(
      $this->Html->image('new_work_request.png'),
      array('controller' => 'workRequests', 'action' => 'create'),
      array('escape' => false, 'style' => 'position: absolute; top:6px; left: 10px; z-index: 1')
    )
  ?>
  <table id="requests">
    <thead>
      <tr>
        <td>No.</td>
        <td>Request ID</td>
        <td>Asset Name</td>
        <td>Asset Number</td>
        <td>Received Date</td>
        <td>Required Date</td>
        <td>Priority</td>
        <td>Type</td>
        <td>Assigned To</td>
        <td>Work Trade</td>
      </tr>
    </thead>
    
    <tbody>
    <? 
      $count = 0;
      foreach ($data as $d){
    ?>
      <tr>
        <td><?= ++$count ?></td>
        <td><?= $this->Html->link($d['WorkRequest']['id'], array('action' => 'edit', $d['WorkRequest']['id'])) ?></td>
        <td><?= $d['Item']['name'] ?></td>
        <td><?= $d['Item']['identifier'] ?></td>
        <td><?= $d['WorkRequest']['date'] ?></td>
        <td><?= $d['WorkRequest']['expire'] ?></td>
        <td><?= $d['WorkPriority']['name'] ?></td>
        <td><?= $d['WorkRequest']['type'] ?></td>
        <td><?= $d['WorkRequest']['owner'] ?></td>
        <td><?= $d['WorkTrade']['name'] ?></td>
      </tr>
    <? } ?>
    </tbody>
  </table>
</div>