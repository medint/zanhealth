<?
  echo $this->Form->create('Change Password');
  echo $this->Form->input('password');
  echo $this->Form->input('password_confirm', array('type' => 'password'));
  echo $this->Form->end(__('Submit'));
?>