<template>
  <div class="container">
    <Title />
    <div class="buttonContainer">
      <Button color="blue" text="Adicionar Tarefa" />
      <Button color="red" text="Remover Tarefa" />
    </div>
    <TasksTitle />
    <TasksContainer>
      <Task />
      <Task />
      <Task />
    </TasksContainer>

  </div>
</template>

<script>
import Title from '@/components/Title.vue'
import Button from '@/components/Button.vue'
import TasksContainer from '@/components/TasksContainer.vue'
import TasksTitle from '@/components/TasksTitle.vue'
export default {
  name: 'IndexPage',
  components: {
    Title,
    Button,
    TasksTitle,
    TasksContainer,
  }
}
</script>

<style>
html {
  background-color: antiquewhite;
  margin: 0;
  padding: 0;
  font-family: 'Roboto', sans-serif;

}

.container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 0.5rem;
  margin: 1rem;

}

.buttonContainer {
  display: flex;
  flex-direction: row;
  justify-content: flex-end;
  width: 100%;
  gap: 1.5rem;
}

p{
  margin: 0;
  padding: 0;
}
</style>