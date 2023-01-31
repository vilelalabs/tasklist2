<template>
  <div class="container">
    <Title />
    <div class="buttonContainer">
      <button @click="handleNewTask">
        <Button color="blue" text="Nova Tarefa"></Button>
      </button>
      <button @click="handleDeleteTasks">
        <Button color="red" text="Remover Tarefa"></Button>
      </button>
    </div>

    <div class="container-newtask">
      <NewTask v-if="addNewTask" @newTask="fillNewTask" />
      <button @click="handleAddNewTask" v-if="addNewTask">
        <Button color="purple" text="Adicionar"></Button>
      </button>
    </div>

    <TasksTitle v-if="thereIsTasks" />
    <TasksContainer>
      <Task v-for="task in updatedTasks" :key="task.id" :id="task.id" :name="task.name" :status="task.status"
        :created_at="task.created_at" :timer="task.timer" @checked="handleChecked(task.id)" />
    </TasksContainer>
  </div>
</template>

<script>

import axios from 'axios'

import Title from '@/components/Title.vue'
import Button from '@/components/Button.vue'
import TasksContainer from '@/components/TasksContainer.vue'
import TasksTitle from '@/components/TasksTitle.vue'
export default {
  name: 'IndexPage',
  data() {
    return {
      addNewTask: false,
      tasks: [],
      checkedTasks: [],
    }
  },
  components: {
    Title,
    Button,
    TasksTitle,
    TasksContainer,
  },
  methods: {
    handleNewTask() {
      this.addNewTask = true;

    },
    fillNewTask(newTask) {
      this.newTask = newTask
    },
    showAllTasks() {
      axios.get('http://localhost:3001/data')
        .then(response => {
          this.tasks = response.data
        })
        .catch(error => {
          console.log(error.response.data)
        })
    },
    handleAddNewTask() {
      this.addNewTask = false;
      axios.post('http://localhost:3001/data', { name: this.newTask })
        .then(response => {
          console.log(response.data)
        })
        .catch(error => {
          console.log(error)
        })
      location.reload()
    },
    handleDeleteTasks() {
      this.checkedTasks.forEach(task => {
        axios.delete(`http://localhost:3001/data`, { params: { id: task } })
          .then(response => {
            console.log(response.data)
            this.checkedTasks = [];

          })
          .catch(error => {
            console.log(error.response.data)
          })
        location.reload()
      })
    },
    handleChecked(id) {
      if (this.checkedTasks.includes(id)) {
        this.checkedTasks.splice(this.checkedTasks.indexOf(id), 1)
        return
      }
      this.checkedTasks.push(id)
    }
  },
  mounted() {
    this.addNewTask = false
    this.showAllTasks();
  },

  computed: {
    thereIsTasks() {
      if (this.tasks.length > 0) {
        return true
      } else {
        return false
      }
    },
    updatedTasks() {
      this.showAllTasks()
      return this.tasks
    }
  },
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

.container-newtask {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  border-radius: 0.5rem;
  margin: 1rem;
  width: 100%;
}

button {
  border: none;
  background-color: transparent;
  cursor: pointer;
}

.buttonContainer {
  display: flex;
  flex-direction: row;
  justify-content: flex-end;
  width: 100%;
  gap: 1.5rem;
}

p {
  margin: 0;
  padding: 0;
}
</style>