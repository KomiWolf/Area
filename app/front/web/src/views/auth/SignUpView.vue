<template>
  <img src="@/assets/logo.png" class="ifttt-logo" />
  <AuthLayout title="Sign Up" linkText="Already have an account? Sign in here" linkPath="/sign-in">
    <form @submit.prevent="submitSignUp" class="sign-up-form">
      <input v-model="email" type="email" placeholder="Email" required />

      <div class="password-container">
        <input :type="showPassword ? 'text' : 'password'" v-model="password" placeholder="Password" required />
        <button type="button" class="toggle-password" @click="togglePassword">
          <img :src="showPassword ? showIcon : hideIcon" alt="toggle password visibility" />
        </button>
      </div>

      <div class="password-container">
        <input :type="showConfirmPassword ? 'text' : 'password'" v-model="confirmPassword"
          placeholder="Confirm Password" required />
        <button type="button" class="toggle-password" @click="toggleConfirmPassword">
          <img :src="showConfirmPassword ? showIcon : hideIcon" alt="toggle confirm password visibility" />
        </button>
      </div>

      <AuthButton text="Get started" />
    </form>

    <div class="separator">Or</div>
    <div class="social-login">
      <AuthButton text="Continue with Google" :buttonColor="'#f4fefe'" :textColor="'fff'" :icon="GoogleIcon"
        :provider="'google'" />
      <AuthButton text="Continue with GitHub" :buttonColor="'#303030'" :icon="GithubIcon" :provider="'github'" />
      <AuthButton text="Continue with Discord" :buttonColor="'#5865F2'" :icon="DiscordIcon" :provider="'discord'" />
      <AuthButton text="Continue with Spotify" :buttonColor="'#1db954'" :icon="SpotifyIcon" :provider="'spotify'" />
    </div>
  </AuthLayout>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
// import { useRouter } from 'vue-router';
import AuthButton from '../../components/AuthButton.vue';
import AuthLayout from '../../components/AuthLayout.vue';
import { queries } from '@/../lib/querier';

import showIcon from '@/assets/show.svg';
import hideIcon from '@/assets/hide.svg';
import GoogleIcon from '@/assets/googleicon.svg';
import GithubIcon from '@/assets/githubicon.svg';
import SpotifyIcon from '@/assets/spotifyicon.svg';
import DiscordIcon from '@/assets/discordicon.svg';

export default defineComponent({
  components: {
    AuthButton,
    AuthLayout,
  },
  data() {
    return {
      email: '',
      password: '',
      confirmPassword: '',
      showPassword: false,
      showConfirmPassword: false,
      showIcon,
      hideIcon,
      GoogleIcon,
      GithubIcon,
      SpotifyIcon,
      DiscordIcon,
    };
  },
  methods: {
    async submitSignUp() {
      if (this.password !== this.confirmPassword) {
        alert('Passwords do not match');
        return;
      }

      try {
        const response = await queries.post('/api/v1/register', {
          email: this.email,
          password: this.password,
        });
        if (response.token) {
          localStorage.setItem('authToken', response.token);
          this.$router.push('/explore/applets');
        } else {
          alert('The authentication have failed.');
        }
      } catch (error) {
        console.error('Erreur lors de l\'inscription:', error);
        alert('Failed to create a new account.');
      }
    },
    togglePassword() {
      this.showPassword = !this.showPassword;
    },
    toggleConfirmPassword() {
      this.showConfirmPassword = !this.showConfirmPassword;
    },
  },
});
</script>


<style scoped>
.ifttt-logo {
  display: block;
  margin: 0 auto 20px;
}

.sign-up-form input {
  display: block;
  width: 100%;
  padding: 15px;
  margin: 10px 0;
  border: 1px solid #ddd;
  border-radius: 10px;
  font-size: 20px;
  box-sizing: border-box;
}

.password-container {
  position: relative;
  display: flex;
  align-items: center;
}

.password-container input {
  width: 100%;
}

.toggle-password {
  position: absolute;
  right: 10px;
  background: none;
  border: none;
  cursor: pointer;
}

.toggle-password img {
  height: 30px;
  width: 30px;
}

.separator {
  text-align: center;
  margin: 20px 0;
  font-size: 14px;
  position: relative;
}

.separator::before,
.separator::after {
  content: '';
  position: absolute;
  top: 50%;
  width: 40%;
  height: 1px;
  background-color: #000;
}

.separator::before {
  left: 0;
}

.separator::after {
  right: 0;
}

.social-login {
  margin: 20px 0;
}

.forgot-password {
  margin-top: 20px;
  color: #000;
  text-decoration: none;
}

.forgot-password:hover {
  text-decoration: underline;
}
</style>
