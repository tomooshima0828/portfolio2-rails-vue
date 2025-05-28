<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <p>
      For a guide and recipes on how to configure / customize this project,<br>
      check out the
      <a href="https://cli.vuejs.org" target="_blank" rel="noopener">vue-cli documentation</a>.
    </p>
    <h3>Message from Rails API:</h3>
    <p>{{ apiMessage }}</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  data() {
    return {
      apiMessage: 'Loading...'
    };
  },
  async mounted() {
    try {
      // docker-compose.ymlで設定したRails APIのURL
      // VUE_APP_API_BASE_URLはビルド時に設定されていれば process.env.VUE_APP_API_BASE_URL で参照可能
      // 今回は直接指定します
      const response = await axios.get('http://localhost:3000/api/v1/greetings');
      this.apiMessage = response.data.message;
    } catch (error) {
      console.error('Error fetching data from API:', error);
      this.apiMessage = 'Failed to load message from API.';
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
