<script type="text/javascript">
  $(window).load(function(){
    init_date = $('#NeedDate').val();
    init_stage = $('#NeedStage').val();
    $('#NeedUpsertForm').submit(function(){
      var $d = $('#NeedDate');
      if (!$d.val() || $d.val() == '0000-00-00' || $d.val() != init_date || $('#NeedStage').val() != init_stage)
        $d.val($.datepicker.formatDate('yy-mm-dd', new Date()));
    });
  });
</script>
<div class="form well">
  <?php echo $this->Form->create('Need'); ?>
    <fieldset>
    <legend><?php echo __('Add Item Request'); ?></legend>
    <?php
      echo $this->Form->hidden('id');
      echo $this->Form->input('name');
      echo $this->Form->input('quantity', array('default' => 1));
      echo $this->Form->input('urgency', array('options' => array('High' => 'High', 'Medium' => 'Medium', 'Low' => 'Low'), 'selected' => 'Medium'));
    ?>
    <br />
    <?php
      echo $this->Form->input('manufacturer');
      echo $this->Form->input('model');
      echo $this->Form->input('stage', array('options' => array('Open' => 'Open','In Shipment' => 'In Shipment','Closed' => 'Closed')));
      echo $this->Form->hidden('date');
    ?>
    <br />
    <?php
      echo $this->Form->input('facility_id', array('empty' => 'Select Facility'));
      echo $this->Form->input('room');
      echo $this->Form->input('user_id', array('label' => 'Requestor'));
    ?>
    <br />
    <?php
      echo $this->Form->input('reason');
      echo $this->Form->input('remarks');
    ?>
    </fieldset>
  <?php echo $this->Form->end(__('Submit')); ?>
</div>