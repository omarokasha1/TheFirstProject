//End Points that's Used in API
//--------------------------------------user----------------------------------
           //<<<<<<<<<<<<<<<<<<<<<<<Get>>>>>>>>>>>>>>>>>>>>
const getProfile = "api/user/get-profile";
const getUserProfile = "api/user/profile";
const enrollUserToCourse = 'api/user/enrollCourse';
const allUsers = "api/user/allUsers";
const getEnrolledCourses = "api/user/enrollCourses";
const getEnrollTracks = "api/user/enrollTracks";
const courses = "api/course/allCourses";
const getCourseByID = "api/course/getCourse";
          //<<<<<<<<<<<<<<<<<<<<<<<Create>>>>>>>>>>>>>>>>>>>>
const login = "api/user/login";
const register = "api/user/register";
const changePassword = "api/user/change-password";
const authorRequest = 'api/user/promot-request';
const uploadImageProfile2 = 'api/user/upload';
const enrollRequest = 'api/user/enroll-request';
const enrollTrack = 'api/user/enrollTrack';
         //<<<<<<<<<<<<<<<<<<<<<<<Update>>>>>>>>>>>>>>>>>>>>
const enrollFreeCourse = 'api/user/enrollCourse';
const updateProfile = "api/user/update-profile";
const wishlist = "api/user/wishList";

//--------------------------------------Author----------------------------------
//-----------------------------Get----------------------------
const getModule = "api/course/authorContents";
const getAuthorCourses = 'api/course/authorCourses';
const getAuthorCoursesPublished = 'api/course/authorCoursesPublished';
const getAuthorTrack = 'api/course/authorTracks';
const getAuthorTrackPublished = 'api/course/authorTracksPublished';
const getAllTrackPublished = 'api/course/allTracksPublished';
const getAssignment = "api/course/authorAssignments";
const getAuthorQuizzes = "api/course/authorQuizzes";
const getAuthorQuestions = "api/course/authorQuestions";
const getAuthor = "api/course/author";
const getAuthorData = "api/user/profile";
const getTrackData = "api/course/getTrack";

//-----------------------------Create----------------------------
const createAuthorCourse = 'api/course/newCourse';
const module = "api/course/newContent";
const createTrack = 'api/course/newTrack';
const newAssignment = "api/course/newAssignment";
const sendCourseRequest = 'api/course/courseRequest';
const sendTrackRequest = 'api/course/trackRequest';
const createAuthorQuizzes = "api/course/newQuizzes";
const createAuthorQuestions = "api/course/newQuestions";

//-----------------------------Update----------------------------
const updateModule = "api/course/update-content";
const updateAssignment = "api/course/update-assignment";
const updateTrack = 'api/course/update-track';
const updateAuthorCourse = 'api/course/update-course';
const updateAuthorQuizzes = "api/course/update-quizzes";
const updateAuthorQuestions = "api/course/update-questions";

//-----------------------------delete----------------------------
const deleteOneModule = "api/course/delete-contents";
const deleteDataAssignment = "api/course/delete-assignment";
const deleteTrackData = 'api/course/delete-track';
const deleteAuthorCourse = 'api/course/delete-courses';
const deleteAuthorQuizzes = "api/course/delete-quizzes";
const deleteAuthorQuestions = "api/course/delete-questions";

//--------------------------------------Manager----------------------------------
//-----------------------------Get----------------------------
const getAuthorRequest = "api/manager/promotRequest";
const getCourseRequest = "api/manager/courseRequest";
const getTrackRequest = "api/manager/trackRequest";

//-----------------------------Update----------------------------
const updateUserRoleAuthor = "api/manager/accept-promot";
const acceptCourseAuthor = "api/manager/accept-course";
const acceptTrackAuthor = "api/manager/accept-track";

//-----------------------------delete----------------------------
const deleteUserRequest = "api/manager/delete-request";
const deleteCourseRequest = "api/manager/delete-course";
const deleteTrackRequest = "api/manager/delete-track";

//--------------------------------------Manager----------------------------------
//-----------------------------Get----------------------------
const getAllAuthors = "api/admin/allAuthors";
const getAllManager = "api/admin/allManagers";
//-----------------------------Update----------------------------
const makeAuthorManager = "api/admin/promot-manager";