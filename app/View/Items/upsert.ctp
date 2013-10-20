<script type="text/javascript">
  $(window).load(function(){
    $('#WorkRequestDate,#WorkRequestExpire').datetimepicker({dateFormat: 'yy-mm-dd', parse: 'loose'});
  });
</script>
<div class="form well">
  <?php echo $this->Form->create('Item'); ?>
    <fieldset>
    <legend><?php echo __('Add New Item'); ?></legend>
    <?php
      echo $this->Form->hidden('id');
      echo $this->Form->input('domain', array('label' => 'Hospital', 'options' => array('U-MM' => 'U-MM','P-CC' => 'P-CC','P-PHL' => 'P-PHL')));
      echo $this->Form->input('tag', array('label' => 'Tag number'));
    ?>
    <br />
    <?php
      echo $this->Form->input('name');
      echo $this->Form->input('utilization', array('options' => array('Normal' => 'Normal', 'No Utilization' => 'No Utilization', 'Very High' => 'Very High', 'Very Low' => 'Very Low','Decommissioned' => 'Decommissioned','Disposed' => 'Disposed')));
      echo $this->Form->input('status', array('options' => array('Fully Functional' => 'Fully Functional','Not Functional' => 'Not Functional','Needs Major Repair' => 'Needs Major Repair','Needs Minor Repair' => 'Needs Minor Repair','Decommissioned' => 'Decommissioned','Disposed' => 'Disposed')));
    ?>
    <br />
    <?php
      echo $this->Form->input('facility_id');
      echo $this->Form->input('floor');
      echo $this->Form->input('room');
    ?>
    <br />
    <?php
      echo $this->Form->input('manufacturer');
      echo $this->Form->input('model');
      echo $this->Form->input('serial_number');
      echo $this->Form->input('year_manufactured');
      echo $this->Form->input('date_received', array('type' => 'text'));
      echo $this->Form->input('price');
      echo $this->Form->input('vendor_id');
      echo $this->Form->input('funding');
      echo $this->Form->input('warranty_expiry', array('type' => 'text'));
      echo $this->Form->input('contract_expiry', array('type' => 'text'));
      echo $this->Form->input('service_agent');
      echo $this->Form->input('category_id');
    ?>
    <br />
    <?php
      echo $this->Form->input('remarks', array('div' => 'description'));
    ?>
    </fieldset>
  <?php echo $this->Form->end(__('Submit')); ?>
  <h4>Work Request History</h4>
  <?= $this->render('/WorkRequests/index', 'ajax');?>
</div>