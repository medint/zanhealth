<style type="text/css">
  #content > form { display: inline-block; margin: 30px }
</style>

<?php echo $this->Form->create('Facility'); ?>
  <?= $this->Form->input('facility') ?>
<?php echo $this->Form->end(array('name' => 'submit', 'label' => 'Search By Facility')); ?>

<?php echo $this->Form->create('WorkRequest'); ?>
  <?= $this->Form->input('requestor') ?>
<?php echo $this->Form->end(array('name' => 'submit', 'label' => 'Search By Work Request')); ?>

<?php echo $this->Form->create('Vendor'); ?>
  <?= $this->Form->input('vendor') ?>
<?php echo $this->Form->end(array('name' => 'submit', 'label' => 'Search By Vendor')); ?>

<?php echo $this->Form->create(); ?>
<?= $this->Form->input('asset_name', array('options' => $asset_name, 'empty' => false, 'label' => 'Asset Name')) ?>
<?php echo $this->Form->end(array('name' => 'submit', 'label' => 'Search By Asset Name')); ?>

<?php echo $this->Form->create(); ?>
<?= $this->Form->input('manufacturer', array('options' => $manufacturers, 'empty' => false, 'label' => 'Manufacturer')) ?>
<?php echo $this->Form->end(array('name' => 'submit', 'label' => 'Search By Manufacturer')); ?>

<?php echo $this->Form->create(); ?>
<?= $this->Form->input('room', array('options' => $rooms, 'empty' => false, 'label' => 'Room')) ?>
<?php echo $this->Form->end(array('name' => 'submit', 'label' => 'Search By Room')); ?>

<?php echo $this->Form->create(); ?>
<?= $this->Form->input('utilization', array('options' => $utilizations, 'empty' => false, 'label' => 'Utilization')) ?>
<?php echo $this->Form->end(array('name' => 'submit', 'label' => 'Search By Utilization')); ?>