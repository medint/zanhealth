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
<? $this->Html->script('needs/details', array('inline' => false)) ?>
<script type="text/javascript">
  $(document).ready(function(){
    var dt = $('#needs').dataTable({
      "bJQueryUI": true,
      "sPaginationType": "full_numbers",
      "bPaginate": false,
      "oLanguage": { "sZeroRecords": "No item requests were found" }
    });
    dt.wrap('<div style="width:100%; max-height: 500px; overflow: auto; white-space: nowrap;">').parent().doubleScroll().css('overflow-y', 'auto');
    
    $('thead.data_filters input').keyup( function () {
      dt.fnFilter( this.value, $('thead.data_filters input, thead.data_filters select').index(this) );
    } );
    $('thead.data_filters select').change( function () {
      dt.fnFilter( this.value, $('thead.data_filters input, thead.data_filters select').index(this) );
    } );
    
    dt.popover( {html: true, placement: 'bottom', selector: 'tbody > tr', content: function(){
      var id = 'async_' + new Date().getTime();
      $.getJSON('http://zanhealth.rcchan.com/items/byName', {name: $(this).find('.asset_name').text()}, function(r){
        $('#' + id).html(Handlebars.templates.details({items: $.map(r, function(e, i){ e.count = i+1; return e; })})).parentsUntil('.popover').parent().css('left', 0);
      });
      return '<div class="asset_popover" id="' + id + '">Loading...</div>';
    }} );
  });
</script>
<div style="position: relative">
  <?=
    $this->Html->link(
      $this->Html->image('new_need.png'),
      array('controller' => 'needs', 'action' => 'create'),
      array('escape' => false, 'style' => 'position: absolute; top:6px; left: 10px; z-index: 1')
    )
  ?>
  <table id="needs">
    <thead>
      <tr>
        <td>No.</td>
        <td>Name</td>
        <td>Facility</td>
        <td>Room</td>
        <td>Manufacturer</td>
        <td>Model</td>
        <td>Quantity</td>
        <td>Urgency</td>
        <td>Reason</td>
        <td>Remarks</td>
        <td>Stage</td>
        <td>Date</td>
      </tr>
    </thead>
    
    <tbody>
    <? 
      $count = 0;
      foreach ($data as $d){
    ?>
      <tr>
        <td><?= ++$count ?></td>
        <td class="asset_name"><?= $this->Html->link($d['Need']['name'], array('action' => 'edit', $d['Need']['id'])) ?></td>
        <td><?= $d['Facility']['name'] ?></td>
        <td><?= $d['Need']['room'] ?></td>
        <td><?= $d['Need']['manufacturer'] ?></td>
        <td><?= $d['Need']['model'] ?></td>
        <td><?= $d['Need']['quantity'] ?></td>
        <td><?= $d['Need']['urgency'] ?></td>
        <td><?= $d['Need']['reason'] ?></td>
        <td><?= $d['Need']['remarks'] ?></td>
        <td><?= $d['Need']['stage'] ?></td>
        <td><?= $d['Need']['date'] ?></td>
      </tr>
    <? } ?>
    </tbody>
  </table>
</div>